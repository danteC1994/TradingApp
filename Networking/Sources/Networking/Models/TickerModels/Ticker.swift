//
//  Ticker.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

public struct Ticker: Decodable, Equatable {
    public let volume: String
    public let high: String
    public let priceVariation: String?
    public let ask: String
    public let bid: String
    
    public init(volume: String, high: String, priceVariation: String?, ask: String, bid: String) {
        self.volume = volume
        self.high = high
        self.priceVariation = priceVariation
        self.ask = ask
        self.bid = bid
    }

    enum CodingKeys: String, CodingKey {
        case volume
        case high
        case priceVariation = "change_24"
        case ask
        case bid
    }
}
