//
//  BookDetailsView.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Networking
import SwiftUI

struct TickerDetailsView: View {
    let bookName: String
    @ObservedObject var viewModel: TickerDetailsViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case let .idle(ticker):
                idleStateView(ticker: ticker.ticker)
            case let .error(errorData):
                errorStateView(errorData: errorData)
            case .loading:
                ProgressView()
            case .empty:
                EmptyView()
            }
        }
        .navigationTitle(bookName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.requestTicker()
            }
        }
    }
    
    private func idleStateView(ticker: TickerDetailsViewData) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(color: .green, radius: 10)
            HStack(alignment: .top) {
                VStack(spacing: 20) {
                    getRow(title: "Volume:", value: ticker.volume)
                    getRow(title: "High:", value: ticker.high)
                    getRow(title: "Price variation:", value: ticker.priceVariation)
                    Spacer()
                    if ticker.ask != nil || ticker.bid != nil {
                        Divider()
                            .foregroundColor(.black)
                    }
                    getRow(title: "Ask:", value: ticker.ask)
                    getRow(title: "Bid:", value: ticker.bid)
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .padding(.vertical, 60)
    }
    
    private func errorStateView(errorData: ErrorStateData) -> some View {
        GenericErrorView(
            title: errorData.errorTitle,
            subtitle: errorData.errorSubtitle,
            retryAction: { Task { await viewModel.requestTicker() } }
        )
    }

    @ViewBuilder
    private func getRow(title: String, value: String?) -> some View {
        if let value {
            RowView(title: title, subtitle: value, subtitleColor: .green)
        }
        EmptyView()
    }
}

#Preview {
    NavigationStack {
        TickerDetailsFactory.TickerDetailsWithMockData()
    }
}
