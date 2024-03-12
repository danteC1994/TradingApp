//
//  BookListService.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Networking
import Foundation

struct BookListService: BookListServiceProtocol {
    let getBooksRequestable: EndpointGetRequest<BookList>

    init(getBooksRequestable: EndpointGetRequest<BookList>) {
        self.getBooksRequestable = getBooksRequestable
    }

    func requestBooks() async -> Result<BookList, APIError> {
        return await getBooksRequestable.asyncGetrequest()
    }
}
