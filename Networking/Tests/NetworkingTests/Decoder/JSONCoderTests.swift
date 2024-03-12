//
//  JSONCoderTests.swift
//  TradingAppTests
//
//  Created by dante canizo on 10/03/2024.
//

@testable import Networking
import XCTest

final class JSONCoderTests: XCTestCase {
    var sut: JsonCoder!

    override func setUp() {
        sut = JsonCoder()
    }

    override func tearDown() {
        sut = nil
    }

    func testDecode_withCorrectBookListData() {
        let data = """
                    {"payload":[{"default_chart":"tradingview","minimum_price":"20000","maximum_price":"7000000","book":"btc_mxn","minimum_value":"10.00","maximum_amount":"600","maximum_value":"200000000","minimum_amount":"0.00000060000","tick_size":"10"}],"success":true
                    }
                    """.data(using: .utf8)
        let bookList = sut.decode(data: data ?? Data(), dataType: BookList.self)

        XCTAssertEqual(bookList?.books?.count, 1)
        XCTAssertEqual(bookList?.books?.first?.name, "btc_mxn")
        XCTAssertEqual(bookList?.books?.first?.maximumPrice, "7000000")
        XCTAssertEqual(bookList?.books?.first?.maximumValue, "200000000")
        XCTAssertEqual(bookList?.books?.first?.minimumValue, "10.00")
    }
}
