//
//  BookListViewModel.swift
//  TradingAppTests
//
//  Created by dante canizo on 09/03/2024.
//

@testable import TradingApp
import XCTest
import struct Networking.Book
import struct Networking.BookList

final class BookListViewModelTests: XCTestCase {
    var sut: BookListViewModel!

    override func setUp() {
        let service = BookListServiceSuccessMock(queryItems: [])
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer(), throttler: ThrottlerMock())
    }

    override func tearDown() {
        sut = nil
    }

    func testRequestBooks_withSuccessResponse() async {
        await sut.requestBooks()
        XCTAssertEqual(
            sut.state,
            .idle(
                .init(
                    bookList: [
                        .init(
                            id: "btc_mxn",
                            bookName: "BTC MXN",
                            maximumPrice: "$ 500.000,00",
                            values: "200.000.000 - 10"
                        )
                    ]
                )
            )
        )
    }

    func testRequestBooks_withSuccessResponse_schedulesThrottler() async {
        await sut.requestBooks()
        XCTAssertNotNil(sut.throttlerCancellable) 
    }

    func testRequestBooks_withErrorResponse_RemovesThrottler() async {
        let expectation = expectation(description: "Throttler was removed successfully")
        let service = BookListServiceSuccesAndErrorWhenRetriessMock()
        let throttler = ThrottlerMock(action: { Task {
            await self.sut.requestBooks()
            XCTAssertNil(self.sut.throttlerCancellable)
            expectation.fulfill()
        } })
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer(), throttler: throttler)
        
        await sut.requestBooks()
        XCTAssertNotNil(sut.throttlerCancellable)
        
        await fulfillment(of: [expectation], timeout: 2)
    }

    func testremoveThrottler_RemovesThrottler() async {
        await sut.requestBooks()
        XCTAssertNotNil(sut.throttlerCancellable)
        sut.removeThrottler()
        XCTAssertNil(sut.throttlerCancellable)
        
    }

    func testRequestBooks_withURLErrorResponse() async {
        let service = BookListServiceURLErrorMock()
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer(), throttler: ThrottlerMock())
        await sut.requestBooks()
        XCTAssertEqual(
            sut.state,
            .error(
                .init(
                    errorTitle: "Something went wrong",
                    errorSubtitle: "We are having technical problems"
                )
            )
        )
    }
    
    func testRequestBooks_withNetworkErrorResponse() async {
        let service = BookListServiceNetworkErrorMock()
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer(), throttler: ThrottlerMock())
        await sut.requestBooks()
        XCTAssertEqual(
            sut.state,
            .error(
                .init(
                    errorTitle: "Try again!",
                    errorSubtitle: "Something went wrong, try reloading"
                )
            )
        )
    }
    
    func testRequestBooks_withDecodingErrorResponse() async {
        let service = BookListServiceDecodingErrorMock()
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer(), throttler: ThrottlerMock())
        await sut.requestBooks()
        XCTAssertEqual(
            sut.state,
            .error(
                .init(
                    errorTitle: "Something went wrong",
                    errorSubtitle: "We are having technical problems"
                )
            )
        )
    }

    func testMapViewData() {
        var books: [Book]
        books = getBookListModel().books ?? []

        let viewData = sut.mapViewData(from: books)

        XCTAssertEqual(viewData.count, 1)
        XCTAssertEqual(viewData.first?.bookName, "BTC MXN")
        XCTAssertEqual(viewData.first?.maximumPrice, "$ 7.000.000,00")
        XCTAssertEqual(viewData.first?.values, "200.000.000 - 10")
    }

    func testFormatValues() {
        let formattedValues = sut.formatValues(minimumValue: 5000, maximumValue: 20000, locale: Locale(identifier: "en-US"))
        
        XCTAssertEqual(formattedValues!, "20.000 - 5.000")
    }
}

// Helpers
extension BookListViewModelTests {
    private func getBookListModel() -> BookList {
        .init(
            books: [
                .init(
                    name: "btc_mxn",
                    maximumPrice: "7000000",
                    maximumValue: "200000000",
                    minimumValue: "10.00"
                )
            ],
            success: true,
            error: nil
        )
    }
}
