//
//  BookDetailsService.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Networking
import Foundation

struct TickerService: TickerServiceProtocol {
    let queryItems: [URLQueryItem]

    func requestTicker() async -> Result<TickerResponse, APIError> {
        return await Networking.TickerService.requestTicker(queryItems: queryItems)
    }
}
