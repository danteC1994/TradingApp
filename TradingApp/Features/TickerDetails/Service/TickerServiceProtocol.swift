//
//  TickerServiceProtocol.swift
//  TradingApp
//
//  Created by dante canizo on 11/03/2024.
//

import Foundation
import Networking

protocol TickerServiceProtocol {
    var queryItems: [URLQueryItem] { get }
    
    func requestTicker() async -> Result<TickerResponse, APIError>
}
