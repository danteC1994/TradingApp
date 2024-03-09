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
        XCTAssertEqual(sut.state, .idle(.init(bookList: getBookListModel())))
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
