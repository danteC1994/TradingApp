//
//  BitsoLocalizerTests.swift
//  TradingAppTests
//
//  Created by dante canizo on 10/03/2024.
//

@testable import TradingApp
import XCTest

final class BitsoLocalizerTests: XCTestCase {
    var sut: BitsoLocalizer!

    override func setUp() {
        sut = BitsoLocalizer()
    }

    override  func tearDown() {
        sut = nil
    }
    
    func testPriceLocalized() {
        let localizedPrice = sut.priceLocalized(price: 20000, locale: Locale(identifier: "en-US"))
        
        XCTAssertEqual(localizedPrice!, "$20,000.00")
    }

    func testDecimalLocalized() {
        let localizedDecimalNumber = sut.decimalLocalized(20000, locale: Locale(identifier: "en-US"))
        
        XCTAssertEqual(try XCTUnwrap(localizedDecimalNumber), "20,000")
    }
}
