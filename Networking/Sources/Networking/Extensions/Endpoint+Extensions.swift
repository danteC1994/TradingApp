//
//  Endpoint+Extensions.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

public extension Endpoint {
    func getUrl() -> URL? {
        var endpointUrlComponents = getEndpointUrlComponents()
        endpointUrlComponents.queryItems = queryItems
        
        guard let url = endpointUrlComponents.url else {
            assertionFailure("Error while creating url for \(endpointUrlComponents.path)")
            return nil
        }
        
        return url
    }

    private func getEndpointUrlComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.basePath + endpointPath
        return components
    }
}
