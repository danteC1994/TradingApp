//
//  File.swift
//  
//
//  Created by dante canizo on 12/03/2024.
//

import Foundation

public struct BookListService: BookListServiceRequestable {
    public static func requestBooks(queryItems: [URLQueryItem]) async -> Result<BookList, APIError> {
        return await EndpointGetRequest(endpoint: BookListEndpoint(queryItems: queryItems)).asyncGetrequest()
    }
}
