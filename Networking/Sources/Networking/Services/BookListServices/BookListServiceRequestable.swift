//
//  File.swift
//  
//
//  Created by dante canizo on 12/03/2024.
//

import Foundation

public protocol BookListServiceRequestable {
    static func requestBooks(queryItems: [URLQueryItem]) async -> Result<BookList, APIError>
}
