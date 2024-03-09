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
        case error
        case loading
        case empty
    }

    struct IdleStateData: Equatable {
        let ticker: Ticker
    }

    let service: TickerService

    @Published private(set) var state: State

    init(state: State, service: TickerService) {
        self.state = state
        self.service = service
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
            state = .idle(.init(ticker: ticker))
        case .failure:
            state = .error
        }
    }
}
