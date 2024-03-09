//
//  Endpoint+Extensions.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

extension Endpoint {
    func getEndpointUrlComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.basePath + endpointPath
        return components
    }

    func getUrlRequest() -> URL? {
        var endpointUrlComponents = getEndpointUrlComponents()
        endpointUrlComponents.queryItems = queryItems
        
        return endpointUrlComponents.url
    }
}
