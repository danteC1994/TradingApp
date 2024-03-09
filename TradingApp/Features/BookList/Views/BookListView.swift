//
//  BookListVIew.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import SwiftUI
import Combine

struct BookListView: View {
    @ObservedObject var viewModel: BookListViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                switch viewModel.state {
                case let .idle(idleData):
                    ScrollView {
                        LazyVStack {
                            ForEach(idleData.bookList) { book in
                                BookListRowView(book: book)
                                    .padding(.horizontal)
                                    
                            }
                        }
                    }
                case .error:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .empty:
                    EmptyView()
                }
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
            )
        )
    )
}
