//
//  BookDetailsViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

final class TickerDetailsViewModel: ObservableObject {
    enum State: Equatable {
        case idle(_ stateData: IdleStateData)
        case error(_ stateData: ErrorStateData)
        case loading
        case empty
    }

    struct IdleStateData: Equatable {
        let ticker: TickerDetailsViewData
    }

    struct ErrorStateData: Equatable {
        let errorTitle: String
        let errorSubtitle: String
    }

    private let service: TickerService
    private let localizer: Localizer

    @Published private(set) var state: State

    init(state: State, service: TickerService, localizer: Localizer) {
        self.state = state
        self.service = service
        self.localizer = localizer
    }

    @MainActor
    func requestTicker() async {
        state = .loading
        let tickerResponse = await service.getTickerRequestable.asyncGetrequest()
        switch tickerResponse {
        case let .success(tickerResponse):
            guard let ticker = tickerResponse.ticker else {
                state = .empty
                return
            }
            
            state = .idle(.init(ticker: mapToViewData(ticker: ticker)))
        case let .failure(error):
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
}

extension TickerDetailsViewModel {
    func mapToViewData(ticker: Ticker) -> TickerDetailsViewData {
        .init(
            volume: ticker.volume.localizedDecimal(localizer: localizer),
            high: ticker.high.localizedDecimal(localizer: localizer),
            priceVariation: ticker.priceVariation?.localizedDecimal(localizer: localizer),
            ask: ticker.ask.localizedDecimal(localizer: localizer),
            bid: ticker.bid.localizedDecimal(localizer: localizer)
        )
    }
    
    func toDecimal(_ num: String) -> String? {
        guard let num = Double(num) else { return nil }
        return localizer.decimalLocalized(num, locale: .current)
    }
}

private extension String {
    func localizedDecimal(localizer: Localizer) -> String? {
        guard let decimal = Double(self) else { return nil }
        return localizer.decimalLocalized(decimal, locale: .current)
    }
}
