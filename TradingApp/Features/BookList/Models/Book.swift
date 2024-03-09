//
//  Book.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

struct Book: Decodable, Identifiable {
    var id: UUID {
        return UUID()
    }

    let name: String
    let maximumPrice: String
    let maximumValue: String
    let minimumValue: String

    enum CodingKeys: String, CodingKey {
        case name = "book"
        case maximumPrice
        case maximumValue
        case minimumValue
    }
}
