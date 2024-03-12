//
//  CoderMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 09/03/2024.
//

@testable import Networking
import Foundation

struct BookListCoderMock: Decoder {
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

struct TickerDetailsCoderMock: Decoder {
    func decode<T>(data: Data, dataType: T.Type) -> T? where T : Decodable {
        return TickerResponse(
            success: true,
            ticker: .init(
                volume: "3925281035",
                high: "1163520",
                priceVariation: "4410",
                ask: "1152580",
                bid: "1150310"
            )
        ) as? T
    }
}

struct CoderErrorMock: Decoder {
    func decode<T>(data: Data, dataType: T.Type) -> T? where T : Decodable {
        return nil
    }
}
