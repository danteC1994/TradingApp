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
            coder: CoderMock(),
            endpoint: EndpointMock(),
            session: SessionSuccessMock()
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

    func testRequestBooks_withURLErrorResponse() async {
        endpointRequester = EndpointGetRequest(
            coder: CoderMock(),
            endpoint: EndpointErrorMock(),
            session: SessionSuccessMock()
        )
        let service = BookListService(getBooksRequestable: endpointRequester)
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
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
        endpointRequester = EndpointGetRequest(
            coder: CoderMock(),
            endpoint: EndpointMock(),
            session: SessionErrorMock()
        )
        let service = BookListService(getBooksRequestable: endpointRequester)
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
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
        endpointRequester = EndpointGetRequest(
            coder: CoderErrorMock(),
            endpoint: EndpointMock(),
            session: SessionSuccessMock()
        )
        let service = BookListService(getBooksRequestable: endpointRequester)
        sut = BookListViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
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
        let data = """
                {"payload":[{"default_chart":"tradingview","minimum_price":"20000","maximum_price":"7000000","book":"btc_mxn","minimum_value":"10.00","maximum_amount":"600","maximum_value":"200000000","minimum_amount":"0.00000060000","tick_size":"10"}],"success":true
                }
                """.data(using: .utf8)
        return JsonCoder().decode(data: data!, dataType: BookList.self)!
    }
}
