//
//  BookDetailsService.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

struct TickerService {
    let getTickerRequestable: EndpointGetRequest<TickerResponse>

    init(getTickerRequestable: EndpointGetRequest<TickerResponse>) {
        self.getTickerRequestable = getTickerRequestable
    }
}
