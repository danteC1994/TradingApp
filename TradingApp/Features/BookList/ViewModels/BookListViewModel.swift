//
//  BookListViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Networking
import Combine
import Foundation

final class BookListViewModel: ObservableObject, StatedViewModel {
    @Published private(set) var state: ViewModelState<BookListIdleStateData, ErrorStateData>

    private(set) var throttlerCancellable: AnyCancellable?
    private let service: BookListServiceProtocol
    private let localizer: Localizer
    private let throttler: Throttable

    init(state: ViewModelState<BookListIdleStateData, ErrorStateData>, service: BookListServiceProtocol, localizer: Localizer, throttler: Throttable) {
        self.state = state
        self.service = service
        self.localizer = localizer
        self.throttler = throttler
    }

    @MainActor
    func requestBooks(showLoading: Bool = true) async {
        if showLoading { state = .loading }
        let bookResponse = await service.requestBooks()
        switch bookResponse {
        case let .success(bookList):
            handleBookListSuccessResult(bookList: bookList)
        case let .failure(error):
            handleBookListErrorResult(error: error)
        }
    }
}

extension BookListViewModel {
    func mapViewData(from bookList: [Book]) -> [BookListViewData] {
        bookList.compactMap { book -> BookListViewData? in
            guard let price = Double(book.maximumPrice),
                  let localizedPrice = localizer.priceLocalized(price: price, locale: .current),
                  let minimumValue = Double(book.minimumValue),
                  let maximumValue = Double(book.maximumValue),
                  let valuesFormatted = formatValues(minimumValue: minimumValue, maximumValue: maximumValue)
            else { return nil }
            return .init(
                id: book.name,
                bookName: updateBookName(book.name),
                maximumPrice: localizedPrice,
                values: valuesFormatted
            )
        }
    }

    func removeThrottler() {
        throttlerCancellable?.cancel()
        throttlerCancellable = nil
    }
    
    private func scheduleThrottler() {
        throttlerCancellable = throttler.throttle(every: 30, on: .main, in: .default) { [weak self] in
            await self?.requestBooks(showLoading: false)
        }
    }

    func formatValues(minimumValue: Double, maximumValue: Double, locale: Locale = .current) -> String? {
        guard let minimumValueFormated = localizer.decimalLocalized(minimumValue, locale: .current),
              let maximumValueFormated = localizer.decimalLocalized(maximumValue, locale: .current)
        else { return nil }

        return "\(maximumValueFormated) - \(minimumValueFormated)"
    }

    private func updateBookName(_ name: String) -> String {
        name.replacingOccurrences(of: "_", with: " ").uppercased()
    }

    private func handleBookListSuccessResult(bookList: BookList) {
        guard let books = bookList.books else {
            removeThrottler()
            state = .error(.init(errorTitle: "Try again!", errorSubtitle: "Something went wrong, try reloading"))
            return
        }
        if throttlerCancellable == nil {
            scheduleThrottler()
        }
        state = .idle(.init(bookList: mapViewData(from: books) ))
    }

    private func handleBookListErrorResult(error: APIError) {
        removeThrottler()
        switch error {
        case .url:
            state = .error(.init(errorTitle: "Something went wrong", errorSubtitle: "We are having technical problems"))
        case .network:
            state = .error(.init(errorTitle: "Try again!", errorSubtitle: "Something went wrong, try reloading"))
        case .decoding:
            state = .error(.init(errorTitle: "Something went wrong", errorSubtitle: "We are having technical problems"))
        }
    }
}
