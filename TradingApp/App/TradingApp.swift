//
//  TradingAppApp.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Networking
import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            TradingApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {

    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}

struct TradingApp: App {
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
                    service: BookListService(
                        getBooksRequestable: .init(
                            endpoint: BookListEndpoint(queryItems: [])
                        )
                    ),
                    localizer: BitsoLocalizer(),
                    throttler: Throttler()
                )
            )
        }
    }
}
