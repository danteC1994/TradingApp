//
//  BookDetailsService.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Networking
import Foundation

struct TickerService: TickerServiceProtocol {
    let getTickerRequestable: EndpointGetRequest<TickerResponse>

    init(getTickerRequestable: EndpointGetRequest<TickerResponse>) {
        self.getTickerRequestable = getTickerRequestable
    }

    func requestTicker() async -> Result<TickerResponse, APIError> {
        return await getTickerRequestable.asyncGetrequest()
    }
}
