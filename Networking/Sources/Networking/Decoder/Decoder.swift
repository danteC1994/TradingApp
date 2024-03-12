//
//  Decoder.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

public protocol Decoder {
    func decode<T: Decodable>(data: Data, dataType: T.Type) -> T?
}
