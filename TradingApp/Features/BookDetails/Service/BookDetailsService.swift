//
//  BookDetailsService.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

struct BookDetailsService {
    let getBooksRequestable: EndpointGetRequest<Book>

    init(getBooksRequestable: EndpointGetRequest<Book>) {
        self.getBooksRequestable = getBooksRequestable
    }
}
