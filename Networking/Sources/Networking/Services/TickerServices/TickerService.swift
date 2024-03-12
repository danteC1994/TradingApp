//
//  File.swift
//  
//
//  Created by dante canizo on 12/03/2024.
//

import Foundation

public struct TickerService: TickerServiceRequestable {
    public static func requestTicker(queryItems: [URLQueryItem]) async -> Result<TickerResponse, APIError> {
        return await EndpointGetRequest(endpoint: TickerEndpoint(queryItems: queryItems)).asyncGetrequest()
    }
}
