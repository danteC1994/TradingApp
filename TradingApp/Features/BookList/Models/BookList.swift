//
//  Models.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

struct BookList: Decodable, Equatable {
    let books: [Book]?
    let success: Bool
    let error: BookAPIError?

    enum CodingKeys: String, CodingKey {
        case books = "payload"
        case success
        case error
    }
}
