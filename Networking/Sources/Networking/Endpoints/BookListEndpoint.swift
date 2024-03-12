//
//  BookListEndpoint.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

struct BookListEndpoint: Endpoint {
    public var baseURL: BaseURL { BitsoAPIURL.prod }
    
    public var endpointPath: String { "/available_books" }
    
    public var queryItems: [URLQueryItem]

    public init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }
}
