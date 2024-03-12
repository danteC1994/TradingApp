//
//  TickerServiceMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 11/03/2024.
//

@testable import TradingApp
import Networking
import Foundation

struct TickerServiceSuccessMock: TickerServiceProtocol {
    var queryItems: [URLQueryItem] = []
    
    func requestTicker() async -> Result<TickerResponse, APIError> {
        .success(
            .init(
                success: true,
                ticker: .init(
                    volume: "3925281035",
                    high: "1163520",
                    priceVariation: "4410",
                    ask: "1152580",
                    bid: "1150310"
                )
            )
        )
    }
}

struct TickerServiceURLErrorMock: TickerServiceProtocol {
    var queryItems: [URLQueryItem] = []
    
    func requestTicker() async -> Result<TickerResponse, APIError> {
        .failure(.url)
    }
}

struct TickerServiceNetworkErrorMock: TickerServiceProtocol {
    var queryItems: [URLQueryItem] = []
    
    func requestTicker() async -> Result<TickerResponse, APIError> {
        .failure(.network)
    }
}

struct TickerServiceDecodingErrorMock: TickerServiceProtocol {
    var queryItems: [URLQueryItem] = []
    
    func requestTicker() async -> Result<TickerResponse, APIError> {
        .failure(.decoding)
    }
}

