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
    var endpointRequester: EndpointGetRequest<BookList>!

    override func setUp() {
        endpointRequester = EndpointGetRequest(
            coder: JsonCoder(),
            endpoint: BookListEndpoint(),
            session: SessionMock()
        )
        let service = BookListService(getBooksRequestable: endpointRequester)
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
    }

    override func tearDown() {
        sut = nil
        endpointRequester = nil
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
        let service = BookListService(getBooksRequestable: endpointRequester)
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
        await sut.requestBooks()
        XCTAssertEqual(sut.state, .error)
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
        let data = """
                {"payload":[{"default_chart":"tradingview","minimum_price":"20000","maximum_price":"7000000","book":"btc_mxn","minimum_value":"10.00","maximum_amount":"600","maximum_value":"200000000","minimum_amount":"0.00000060000","tick_size":"10"}],"success":true
                }
                """.data(using: .utf8)
        return JsonCoder().decode(data: data!, dataType: BookList.self)!
    }
}
