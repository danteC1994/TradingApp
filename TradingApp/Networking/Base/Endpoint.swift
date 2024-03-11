//
//  Endpoint.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

protocol Endpoint {
    var baseURL: BaseURL { get }
    var endpointPath: String { get }
    var queryItems: [URLQueryItem] { get }

    func getUrl() -> URL?
}
