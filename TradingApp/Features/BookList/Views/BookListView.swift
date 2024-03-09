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
                Color.secondary
                    .ignoresSafeArea()
                switch viewModel.state {
                case let .idle(idleData):
                    ScrollView {
                        LazyVStack {
                            
                        }
                    }
                case .error:
                    EmptyView()
                case .loading:
                    EmptyView()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.requestBooks()
            }
        }
    }
}

#Preview {
    BookListView(
        viewModel: .init(
            state: .idle(
                .init(
                    bookList: .init(
                        books: [
                            .init(
                                name: "BTC MXN",
                                maximumPrice: "500000.00",
                                maximumValue: "200000000.00",
                                minimumValue: "10.00000000"
                            )
                        ],
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
