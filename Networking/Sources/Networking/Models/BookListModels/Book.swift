//
//  Book.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

public struct Book: Decodable, Identifiable, Equatable {
    public var id: String {
        name
    }
    public let name: String
    public let maximumPrice: String
    public let maximumValue: String
    public let minimumValue: String

    public init(name: String, maximumPrice: String, maximumValue: String, minimumValue: String) {
        self.name = name
        self.maximumPrice = maximumPrice
        self.maximumValue = maximumValue
        self.minimumValue = minimumValue
    }

    enum CodingKeys: String, CodingKey {
        case name = "book"
        case maximumPrice
        case maximumValue
        case minimumValue
    }
}
