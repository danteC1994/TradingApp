//
//  BookListVIew.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Networking
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
                    idleStateView(bookList: idleData.bookList)
                case let .error(errorData):
                    errorStateView(errorData: errorData)
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

    private func idleStateView(bookList: [BookListViewData]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(bookList, id: \.id) { book in
                    NavigationLink {
                        TickerDetailsFactory.TickerDetails(
                            viewTitle: book.bookName,
                            bookID: book.id
                        )
                    } label: {
                        BookListRowView(book: book)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.top)
        .navigationTitle("Bitso")
    }

    private func errorStateView(errorData: BookListViewModel.ErrorStateData) -> some View {
        GenericErrorView(
            title: errorData.errorTitle,
            subtitle: errorData.errorSubtitle,
            retryAction: { Task { await viewModel.requestBooks() } }
        )
    }
}

#Preview {
    BookListFactory.BookListWithMockData()
}
