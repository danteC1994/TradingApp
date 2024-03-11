//
//  CoderMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 09/03/2024.
//

@testable import TradingApp
import Foundation

struct CoderMock: Decoder {
    func decode<T>(data: Data, dataType: T.Type) -> T? where T : Decodable {
        return BookList(
            books: [
                .init(
                    name: "btc_mxn",
                    maximumPrice: "500000.00",
                    maximumValue: "200000000.00",
                    minimumValue: "10.00000000"
                )
            ],
            success: true,
            error: nil
        ) as? T
    }
}

struct CoderErrorMock: Decoder {
    func decode<T>(data: Data, dataType: T.Type) -> T? where T : Decodable {
        return nil
    }
}
