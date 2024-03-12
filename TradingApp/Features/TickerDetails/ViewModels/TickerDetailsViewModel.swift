//
//  BookDetailsViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Networking
import Foundation

final class TickerDetailsViewModel: ObservableObject, StatedViewModel {
    @Published private(set) var state: ViewModelState<TickerIdleStateData, ErrorStateData>

    private let service: TickerServiceProtocol
    private let localizer: Localizer

    init(state: ViewModelState<TickerIdleStateData, ErrorStateData>, service: TickerServiceProtocol, localizer: Localizer) {
        self.state = state
        self.service = service
        self.localizer = localizer
    }

    @MainActor
    func requestTicker() async {
        state = .loading
        let tickerResponse = await service.requestTicker()
        switch tickerResponse {
        case let .success(tickerResponse):
            handleTickerSuccessResponse(tickerResponse: tickerResponse)
        case let .failure(error):
            handleTickerErrorResponse(error: error)
        }
    }
}

extension TickerDetailsViewModel {
    func mapToViewData(ticker: Ticker) -> TickerDetailsViewData {
        .init(
            volume: ticker.volume.localizedDecimal(localizer: localizer),
            high: ticker.high.localizedDecimal(localizer: localizer),
            priceVariation: ticker.priceVariation.localizedDecimal(localizer: localizer),
            ask: ticker.ask.localizedDecimal(localizer: localizer),
            bid: ticker.bid.localizedDecimal(localizer: localizer)
        )
    }

    private func handleTickerSuccessResponse(tickerResponse: TickerResponse) {
        guard let ticker = tickerResponse.ticker else {
            state = .error(.init(errorTitle: "Try again!", errorSubtitle: "Something went wrong, try reloading"))
            return
        }
        
        state = .idle(.init(ticker: mapToViewData(ticker: ticker)))
    }

    private func handleTickerErrorResponse(error: APIError) {
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

private extension String {
    func localizedDecimal(localizer: Localizer) -> String? {
        guard let decimal = Double(self) else { return nil }
        return localizer.decimalLocalized(decimal, locale: .current)
    }
}
