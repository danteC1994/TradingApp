//
//  BookListViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Foundation

final class BookListViewModel: ObservableObject {
    enum State: Equatable {
        case idle(_ stateData: IdleStateData)
        case error
        case loading
        case empty
    }

    struct IdleStateData: Equatable {
        let bookList: [BookListViewData]
    }

    let service: BookListService
    let localizer: Localizer

    @Published private(set) var state: State

    init(state: State, service: BookListService, localizer: Localizer) {
        self.state = state
        self.service = service
        self.localizer = localizer
    }

    @MainActor
    func requestBooks() async {
        state = .loading
        let bookResponse = await service.getBooksRequestable.asyncGetrequest()
        switch bookResponse {
        case let .success(bookList):
            guard let books = bookList.books else {
                state = .empty
                return
            }
            self.state = .idle(.init(bookList: mapViewData(from: books) ))
        case .failure:
            self.state = .error
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
                    bookName: updateBookName(book.name),
                    maximumPrice: localizedPrice,
                    values: valuesFormatted
                )
        }
    }

//    func maximumPriceLocalized(price: Double, locale: Locale = .current) -> String? {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.locale = locale
//        
//        return formatter.string(from: NSNumber(value: price))
//    }

//    func formatToDecimal(_ number: Double, locale: Locale = .current) -> String? {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.locale = locale
//
//        return formatter.string(from: NSNumber(value: number))
//    }

    func formatValues(minimumValue: Double, maximumValue: Double, locale: Locale = .current) -> String? {
        guard let minimumValueFormated = localizer.decimalLocalized(minimumValue, locale: .current),
              let maximumValueFormated = localizer.decimalLocalized(maximumValue, locale: .current)
        else { return nil }

        return "\(maximumValueFormated) - \(minimumValueFormated)"
    }

    private func updateBookName(_ name: String) -> String {
        name.replacingOccurrences(of: "_", with: " ").uppercased()
    }
}
