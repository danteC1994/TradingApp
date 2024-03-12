//
//  File.swift
//  
//
//  Created by dante canizo on 12/03/2024.
//

import Foundation

public protocol TickerServiceRequestable {
    static func requestTicker(queryItems: [URLQueryItem]) async -> Result<TickerResponse, APIError>
}
