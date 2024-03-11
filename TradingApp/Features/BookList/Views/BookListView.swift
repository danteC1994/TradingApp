//
//  BookListVIew.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import SwiftUI
import Combine

struct BookListView: View {
    @ObservedObject private(set) var viewModel: BookListViewModel
    private(set) var selectedBookID: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case let .idle(idleData):
                    ScrollView {
                        LazyVStack {
                            ForEach(idleData.bookList, id: \.id) { book in
                                NavigationLink {
                                    TickerDetailsView(bookName: book.bookName, viewModel: .init(state: .idle(.init(ticker: .init(volume: "", high: "", priceVariation: "", ask: "", bid: ""))), service: .init(getTickerRequestable: .init(coder: JsonCoder(), endpoint: TickerEndpoint(queryItems: [.init(name: "book", value: book.id)]), session: URLSession(configuration: .default))), localizer: BitsoLocalizer()))
                                } label: {
                                    BookListRowView(book: book)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .navigationTitle("Bitso")
                case let .error(errorData):
                    GenericErrorView(
                        title: errorData.errorTitle,
                        subtitle: errorData.errorSubtitle,
                        retryAction: { Task { await viewModel.requestBooks() } }
                    )
                case .loading:
                    ProgressView()
                case .empty:
                    EmptyView()
                }
            }
            .onDisappear {
                viewModel.removeThrottler()
            }

        }
        .onAppear {
            Task {
                await viewModel.requestBooks()
            }
        }
        .refreshable {
            await viewModel.requestBooks()
        }
    }
}

#Preview {
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
            service: .init(
                getBooksRequestable: .init(
                    coder: JsonCoder(),
                    endpoint: BookListEndpoint(queryItems: []),
                    session: URLSession(configuration: .default)
                )
            ),
            localizer: BitsoLocalizer(), throttler: Throttler()
        )
    )
}
