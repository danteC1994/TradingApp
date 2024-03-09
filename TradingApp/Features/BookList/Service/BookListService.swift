//
//  BookListService.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

struct BookListService {
    let getBooksRequestable: EndpointGetRequest<BookList>

    init(getBooksRequestable: EndpointGetRequest<BookList>) {
        self.getBooksRequestable = getBooksRequestable
    }
}
