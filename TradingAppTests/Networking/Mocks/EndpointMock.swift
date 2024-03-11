//
//  EndpointMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 10/03/2024.
//

@testable import TradingApp
import Foundation

struct EndpointMock: Endpoint {
    var baseURL: BaseURL { BitsoAPIURL.sandbox }
    
    var endpointPath: String { "/any" }
    
    var queryItems: [URLQueryItem]

    init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }
}

struct EndpointErrorMock: Endpoint {
    var baseURL: BaseURL { BitsoAPIURL.sandbox }
    
    var endpointPath: String { "/any" }
    
    var queryItems: [URLQueryItem]

    init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }

    func getUrlRequest() -> URL? {
        return nil
    }
}
