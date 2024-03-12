//
//  JsonCoder.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

/// This struct is meant to implement coding data behaviors, such as encoding and decoding.
public struct JsonCoder: Decoder {
    private var decoder: JSONDecoder

    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    /// Decodes a generic type from specific data.
    public func decode<T: Decodable>(data: Data, dataType: T.Type) -> T? {
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            assertionFailure("Error while decoding \(T.self)")
            return nil
        }
    }
}
