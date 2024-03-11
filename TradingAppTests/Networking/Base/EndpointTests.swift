//
//  EndpointTests.swift
//  TradingAppTests
//
//  Created by dante canizo on 10/03/2024.
//

@testable import TradingApp
import XCTest

final class EndpointTests: XCTestCase {
    var sut: Endpoint!

    override func setUp() {
        sut = EndpointMock()
    }

    override func tearDown() {
        sut = nil
    }

    func testGetUrl_withoutQueryParameters() {
        let url = sut.getUrl()

        XCTAssertEqual(url?.absoluteString, "https://sandbox.bitso.com/api/v3/any?")
    }

    func testGetUrl_withQueryParameters() {
        sut = EndpointMock(queryItems: [.init(name: "book", value: "btc_mxn")])
        let url = sut.getUrl()

        XCTAssertEqual(url?.absoluteString, "https://sandbox.bitso.com/api/v3/any?book=btc_mxn")
    }
}
