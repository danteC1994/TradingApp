//
//  TickerResponse.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

public struct TickerResponse: Decodable {
    public let success: Bool
    public let ticker: Ticker?
    
    public init(success: Bool, ticker: Ticker?) {
        self.success = success
        self.ticker = ticker
    }
    
    enum CodingKeys: String, CodingKey {
        case success
        case ticker = "payload"
    }
}
