//
//  BookDetailsEndpoint.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

/// Ticker endpoint implementation.
/// Find more info: https://docs.bitso.com/bitso-api/docs/ticker.
struct TickerEndpoint: Endpoint {
    public var baseURL: BaseURL { BitsoAPIURL.prod }
    
    public var endpointPath: String { "/ticker" }
    
    public var queryItems: [URLQueryItem]
    
    public init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }
}
