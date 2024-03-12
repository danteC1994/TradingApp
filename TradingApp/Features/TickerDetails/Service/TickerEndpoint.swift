//
//  BookDetailsEndpoint.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Networking
import Foundation

struct TickerEndpoint: Endpoint {
    var baseURL: BaseURL { BitsoAPIURL.prod }
    
    var endpointPath: String { "/ticker" }
    
    var queryItems: [URLQueryItem]
    
    init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }
}
