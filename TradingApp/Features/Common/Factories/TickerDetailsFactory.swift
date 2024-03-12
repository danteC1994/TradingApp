//
//  TickerDetailsFactory.swift
//  TradingApp
//
//  Created by dante canizo on 12/03/2024.
//

import SwiftUI
import Foundation

struct TickerDetailsFactory {
    static func TickerDetails(viewTitle: String, bookID: String) -> some View {
        TickerDetailsView(
            bookName: viewTitle,
            viewModel: .init(
                state: .idle(
                    .init(
                        ticker: .init(
                            volume: "",
                            high: "",
                            priceVariation: "",
                            ask: "",
                            bid: ""
                        )
                    )
                ),
                service: TickerService(
                    queryItems: [
                        .init(
                            name: "book",
                            value: bookID
                        )
                    ]
                ),
                localizer: BitsoLocalizer()
            )
        )
    }

    static func TickerDetailsWithMockData() -> some View {
        Self.TickerDetails(viewTitle: "BTC MXN", bookID: "btc_mxn")
    }
}
