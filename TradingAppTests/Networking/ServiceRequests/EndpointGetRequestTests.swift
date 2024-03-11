//
//  EndpointGetRequestTests.swift
//  TradingAppTests
//
//  Created by dante canizo on 10/03/2024.
//

@testable import TradingApp
import XCTest

final class EndpointGetRequestTests: XCTestCase {
    var sut: EndpointGetRequest<BookList>!

    override func setUp() {
        sut = EndpointGetRequest(
            coder: CoderMock(),
            endpoint: EndpointMock(),
            session: SessionSuccessMock()
        )
    }

    override func tearDown() {
        sut = nil
    }

    func testGetRequest_withSuccessResponse() async {
        let response = await sut.asyncGetrequest()

        guard case let .success(response) = response else {
            XCTFail()
            return
        }

        XCTAssertNotNil(response)
        XCTAssertEqual(response.books?.count, 1)
    }
    
    func testGetRequest_withEndpointURLError() async {
        sut = EndpointGetRequest(
            coder: CoderMock(),
            endpoint: EndpointErrorMock(),
            session: SessionSuccessMock()
        )

        let response = await sut.asyncGetrequest()
        
        guard case let .failure(error) = response else {
            XCTFail()
            return
        }

        XCTAssertNotNil(response)
        XCTAssertEqual(error, APIError.url)
    }

    func testGetRequest_withNetworkError() async {
        sut = EndpointGetRequest(
            coder: CoderMock(),
            endpoint: EndpointMock(),
            session: SessionErrorMock()
        )

        let response = await sut.asyncGetrequest()
        
        guard case let .failure(error) = response else {
            XCTFail()
            return
        }

        XCTAssertNotNil(response)
        XCTAssertEqual(error, APIError.network)
    }

    func testGetRequest_withDecodingError() async {
        sut = EndpointGetRequest(
            coder: CoderErrorMock(),
            endpoint: EndpointMock(),
            session: SessionSuccessMock()
        )

        let response = await sut.asyncGetrequest()
        
        guard case let .failure(error) = response else {
            XCTFail()
            return
        }

        XCTAssertNotNil(response)
        XCTAssertEqual(error, APIError.decoding)
    }
}
