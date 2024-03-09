//
//  SessionMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 09/03/2024.
//

@testable import TradingApp
import Foundation

struct SessionMock: Session {
    let data = """
                {"payload":[{"default_chart":"tradingview","minimum_price":"20000","maximum_price":"7000000","book":"btc_mxn","minimum_value":"10.00","maximum_amount":"600","maximum_value":"200000000","minimum_amount":"0.00000060000","tick_size":"10"}],"success":true
                }
                """.data(using: .utf8)
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return (data!, URLResponse())
    }
}
