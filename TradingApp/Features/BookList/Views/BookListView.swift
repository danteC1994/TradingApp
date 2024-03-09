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
    }
}

#Preview {
    BookListView(
        viewModel: .init(
            state: .idle(
                .init(
                    bookName: "BTC MXN",
                    maximumPrice: "500000.00",
                    maximumValue: "200000000.00",
                    minimumValue: "10.00000000"
                )
            )
        )
    )
}
