//
//  Models.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

public struct BookList: Decodable, Equatable {
    public let books: [Book]?
    public let success: Bool
    public let error: BookAPIError?

    public init(books: [Book]?, success: Bool, error: BookAPIError?) {
        self.books = books
        self.success = success
        self.error = error
    }

    enum CodingKeys: String, CodingKey {
        case books = "payload"
        case success
        case error
    }
}
