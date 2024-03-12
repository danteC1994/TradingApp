//
//  BitsoAPIURLTests.swift
//  TradingAppTests
//
//  Created by dante canizo on 10/03/2024.
//

@testable import Networking
import XCTest

final class BitsoAPIURLTests: XCTestCase {
    var sut: BitsoAPIURL!

    func testBitsoAPIURLSandboxComponents() {
        sut = BitsoAPIURL.sandbox

        XCTAssertEqual(sut.scheme, "https")
        XCTAssertEqual(sut.host, "sandbox.bitso.com")
        XCTAssertEqual(sut.basePath, "/api/v3")
    }

    func testBitsoAPIURLProdComponents() {
        sut = BitsoAPIURL.prod

        XCTAssertEqual(sut.scheme, "https")
        XCTAssertEqual(sut.host, "api.bitso.com")
        XCTAssertEqual(sut.basePath, "/v3")
    }
}
