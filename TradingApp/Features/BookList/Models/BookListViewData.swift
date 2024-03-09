//
//  BookListViewData.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

struct BookListViewData: Equatable, Identifiable {
    var id: UUID {
        return UUID()
    }

    let bookName: String
    let maximumPrice: String
    let values: String
}
