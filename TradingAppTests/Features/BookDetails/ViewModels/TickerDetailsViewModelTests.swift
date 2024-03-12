//
//  TickerDetailsViewModelTests.swift
//  TradingAppTests
//
//  Created by dante canizo on 10/03/2024.
//

@testable import TradingApp
import Networking
import XCTest

final class TickerDetailsViewModelTests: XCTestCase {
    var sut: TickerDetailsViewModel!
    var endpointRequester: EndpointGetRequest<TickerResponse>!

    override func setUp() {
        let service = TickerServiceSuccessMock()
        sut = TickerDetailsViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
    }

    override func tearDown() {
        sut = nil
        endpointRequester = nil
    }

    func testRequestTicker_withSuccessResponse() async {
        await sut.requestTicker()
        XCTAssertEqual(
            sut.state,
            .idle(
                .init(
                    ticker: .init(
                        volume: "3.925.281.035",
                        high: "1.163.520",
                        priceVariation: "4.410",
                        ask: "1.152.580",
                        bid: "1.150.310"
                    )
                )
            )
        )
    }

    func testRequestTicker_withURLErrorResponse() async {
        let service = TickerServiceURLErrorMock()
        sut = TickerDetailsViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
        await sut.requestTicker()
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

    func testRequestTicker_withNetworkErrorResponse() async {
        let service = TickerServiceNetworkErrorMock()
        sut = TickerDetailsViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
        await sut.requestTicker()
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

    func testRequestTicker_withDecodingErrorResponse() async {
        let service = TickerServiceDecodingErrorMock()
        sut = TickerDetailsViewModel(state: .loading, service: service, localizer: BitsoLocalizer())
        await sut.requestTicker()
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

    func testMapToViewData() {
        let viewData = sut.mapToViewData(
            ticker: .init(
                volume: "39253",
                high: "1163520",
                priceVariation: "4410",
                ask: "1152580",
                bid: "1150310"
            )
        )

        XCTAssertEqual(viewData.volume, "39.253")
        XCTAssertEqual(viewData.high, "1.163.520")
        XCTAssertEqual(viewData.priceVariation, "4.410")
        XCTAssertEqual(viewData.ask, "1.152.580")
        XCTAssertEqual(viewData.bid, "1.150.310")
    }
}
