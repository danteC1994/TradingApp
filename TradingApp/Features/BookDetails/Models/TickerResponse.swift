//
//  TickerResponse.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

struct TickerResponse: Decodable {
    let success: Bool
    let ticker: Ticker?
    
    enum CodingKeys: String, CodingKey {
        case success
        case ticker = "payload"
    }
}
