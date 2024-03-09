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
                                books: [],
                                success: true,
                                error: nil
                            )
                        )
                    ),
                    service: .init(
                        getBooksRequestable: .init(
                            coder: JsonCoder(),
                            endpoint: BookListEndpoint(queryItems: []),
                            session: .init(configuration: .default)
                        )
                    )
                )
            )
        }
    }
}
