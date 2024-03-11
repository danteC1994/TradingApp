//
//  SessionMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 09/03/2024.
//

@testable import TradingApp
import Foundation

struct BookListSessionSuccessMock: Session {
    let data = """
                {"payload":[{"default_chart":"tradingview","minimum_price":"20000","maximum_price":"7000000","book":"btc_mxn","minimum_value":"10.00","maximum_amount":"600","maximum_value":"200000000","minimum_amount":"0.00000060000","tick_size":"10"}],"success":true
                }
                """.data(using: .utf8)

    func data(from url: URL) async throws -> (Data, URLResponse) {
        guard let data else { throw APIError.url }
        return (data, URLResponse())
    }
}

struct TickerDetailsSessionSuccessMock: Session {
    let data = """
                {"success":true,"payload":{"high":"1163520","last":"1150310","created_at":"2024-03-09T20:58:01+00:00","book":"btc_mxn","volume":"39.25281035","vwap":"1149214.3012427282","low":"1141960","ask":"1152580","bid":"1150310","change_24":"4410","rolling_average_change":{"6":"-0.0243"}}}
                """.data(using: .utf8)

    func data(from url: URL) async throws -> (Data, URLResponse) {
        guard let data else { throw APIError.url }
        return (data, URLResponse())
    }
}

struct SessionErrorMock: Session {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        throw APIError.url
    }
}

class BookListSessionSuccessAndErrorWhenRetriesMock: Session {
    private var retried = false
    var data: Data? {
        if retried { return nil }
        return """
                {"payload":[{"default_chart":"tradingview","minimum_price":"20000","maximum_price":"7000000","book":"btc_mxn","minimum_value":"10.00","maximum_amount":"600","maximum_value":"200000000","minimum_amount":"0.00000060000","tick_size":"10"}],"success":true
                }
                """.data(using: .utf8)
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        defer {
            retried = true
        } 
        guard let data else { throw APIError.url }
        return (data, URLResponse())
    }
}
