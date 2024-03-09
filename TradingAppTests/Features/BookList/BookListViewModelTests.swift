//
//  BookListViewModel.swift
//  TradingAppTests
//
//  Created by dante canizo on 09/03/2024.
//

@testable import TradingApp
import XCTest

final class BookListViewModelTests: XCTestCase {
    var sut: BookListViewModel!

    override func setUp() {
        let endpointRequester: EndpointGetRequest<BookList> = EndpointGetRequest(
            coder: JsonCoder(),
            endpoint: BookListEndpoint(),
            session: SessionMock()
        )
        let service = BookListService(getBooksRequestable: endpointRequester)
        sut = BookListViewModel(state: .loading, service: service)
    }

    func testRequestBooks_withSuccessResponse() async {
        await sut.requestBooks()
        XCTAssertEqual(
            sut.state,
            .idle(
                .init(
                    bookList: [
                        .init(
                            bookName: "BTC MXN",
                            maximumPrice: "500000.00",
                            values: "200000000.00 - 10.00000000"
                        )
                    ]
                )
            )
        )
    }

    func testRequestBooks_withErrorResponse() async {
        let endpointRequester: EndpointGetRequest<BookList> = EndpointGetRequest(
            coder: CoderMock(),
            endpoint: BookListEndpoint(),
            session: SessionMock()
        )
        let service = BookListService(getBooksRequestable: endpointRequester)
        sut = BookListViewModel(state: .loading, service: service)
        await sut.requestBooks()
        XCTAssertEqual(sut.state, .error)
    }

    func testMaximumPriceLocalized() {
        let localizedPrice = sut.maximumPriceLocalized(price: 20000, locale: Locale(identifier: "en-US"))
        
        XCTAssertEqual(localizedPrice!, "$20,000.00")
    }

    func testFormatDecimalValues() {
        let localizedDecimalNumber = sut.formatToDecimal(20000, locale: Locale(identifier: "en-US"))
        
        XCTAssertEqual(try XCTUnwrap(localizedDecimalNumber), "20,000")
    }

    func testFormatValues() {
        let formattedValues = sut.formatValues(minimumValue: 5000, maximumValue: 20000, locale: Locale(identifier: "en-US"))
        
        XCTAssertEqual(formattedValues!, "20.000 - 5.000")
    }
}

// Helpers
extension BookListViewModelTests {
    private func getBookListModel() -> BookList {
        let data = """
                {"payload":[{"default_chart":"tradingview","minimum_price":"20000","maximum_price":"7000000","book":"btc_mxn","minimum_value":"10.00","maximum_amount":"600","maximum_value":"200000000","minimum_amount":"0.00000060000","tick_size":"10"}],"success":true
                }
                """.data(using: .utf8)
        return JsonCoder().decode(data: data!, dataType: BookList.self)!
    }
}
