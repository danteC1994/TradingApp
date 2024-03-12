//
//  APIError.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Foundation

public enum APIError: Error {
    case url
    case network
    case decoding
}
