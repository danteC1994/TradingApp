//
//  BookListFactory.swift
//  TradingApp
//
//  Created by dante canizo on 12/03/2024.
//

import SwiftUI
import Foundation

struct BookListFactory {
    static func emptyBookListView() -> some View {
        BookListView(
            viewModel: .init(
                state: .idle(
                    .init(
                        bookList: .init([])
                    )
                ),
                service: BookListService(
                    queryItems: []
                ),
                localizer: BitsoLocalizer(),
                throttler: Throttler()
            )
        )
    }

    static func BookListWithMockData() -> some View {
        BookListView(
            viewModel: .init(
                state: .idle(
                    .init(
                        bookList: .init(
                            [
                                .init(
                                    id: "btc_mxn",
                                    bookName: "BTC MXN",
                                    maximumPrice: "500000.00",
                                    values: "200000000.00 - 10.00000000"
                                )
                            ]
                        )
                    )
                ),
                service: BookListService(
                    queryItems: []
                ),
                localizer: BitsoLocalizer(), throttler: Throttler()
            )
        )
    }

    static func rowViewWithData() -> some View {
        BookListRowView(
            book: .init(
                id: "btc_mxn",
                bookName: "BTC MXN",
                maximumPrice: "500000.00",
                values: "200000000.00 - 10.00000000"
            )
        )
    }
}
