//
//  BookListService.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Networking
import Foundation

struct BookListService: BookListServiceProtocol {
    let queryItems: [URLQueryItem]

    func requestBooks() async -> Result<BookList, APIError> {
        return await Networking.BookListService.requestBooks(queryItems: queryItems)
    }
}
