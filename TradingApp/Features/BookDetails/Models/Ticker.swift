//
//  Ticker.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

struct Ticker: Decodable, Equatable {
    let volume: String
    let high: String
    let priceVariation: String
    let ask: String
    let bid: String

    enum CodingKeys: String, CodingKey {
        case volume
        case high
        case priceVariation = "change_24"
        case ask
        case bid
    }
}
