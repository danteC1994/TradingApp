//
//  BookListServiceProtocol.swift
//  TradingApp
//
//  Created by dante canizo on 11/03/2024.
//

import Foundation
import Networking

protocol BookListServiceProtocol {
    func requestBooks() async -> Result<BookList, APIError>
}
