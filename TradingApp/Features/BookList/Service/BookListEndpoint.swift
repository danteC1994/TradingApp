//
//  BookListEndpoint.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

struct BookListEndpoint: Endpoint {
    var baseURL: BaseURL { BitsoAPIURL.prod }
    
    var endpointPath: String { "/available_books" }
    
    var queryItems: [URLQueryItem]

    init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }
}
