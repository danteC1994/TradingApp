//
//  TradingAppApp.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import SwiftUI

@main
struct TradingAppApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView(
                viewModel: .init(
                    state: .idle(
                        .init(
                            bookList: .init(
                                [
                                    .init(
                                        id: "btc+mxn",
                                        bookName: "BTC MXN",
                                        maximumPrice: "500000.00",
                                        values: "200000000.00 - 10.00000000"
                                    )
                                ]
                            )
                        )
                    ),
                    service: .init(
                        getBooksRequestable: .init(
                            coder: JsonCoder(),
                            endpoint: BookListEndpoint(queryItems: []),
                            session: URLSession(configuration: .default)
                        )
                    ),
                    localizer: BitsoLocalizer()
                )
            )
        }
    }
}
