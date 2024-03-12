//
//  BookError.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

public struct BookAPIError: Decodable, Equatable {
    public let message: String
}
