//
//  BitsoAPIURL.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

enum BitsoAPIURL: BaseURL {
    case sandbox
    case prod
    
    var scheme: String { "https" }
    
    var host: String {
        switch self {
        case .sandbox:
            "sandbox.bitso.com"
        case .prod:
            "api.bitso.com"
        }
    }
    
    var basePath: String {
        switch self {
        case .sandbox:
            "/api/v3"
        case .prod:
            "/v3"
        }
    }
}
