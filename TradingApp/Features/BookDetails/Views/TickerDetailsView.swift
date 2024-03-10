//
//  BookDetailsView.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import SwiftUI

struct TickerDetailsView: View {
    @ObservedObject var viewModel: TickerDetailsViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case let .idle(ticker):
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.white)
                        .shadow(color: .green, radius: 10)
                    HStack {
                        VStack(spacing: 20) {
                            RowView(title: "Volume:", subtitle: ticker.ticker.volume)
                            RowView(title: "High:", subtitle: ticker.ticker.high)
                            RowView(title: "Price variation:", subtitle: ticker.ticker.priceVariation ?? "")
                            Spacer()
                            Divider()
                                .foregroundColor(.black)
                            RowView(title: "Ask:", subtitle: ticker.ticker.ask)
                            RowView(title: "Bid:", subtitle: ticker.ticker.bid)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.vertical, 100)
            case .error:
                EmptyView()
            case .loading:
                ProgressView()
            case .empty:
                EmptyView()
            }
        }
        .onAppear {
            Task {
                await viewModel.requestTicker()
            }
        }
    }
}

#Preview {
    TickerDetailsView(viewModel: .init(state: .idle(.init(ticker: .init(volume: "", high: "", priceVariation: "", ask: "", bid: ""))), service: .init(getTickerRequestable: .init(coder: JsonCoder(), endpoint: TickerEndpoint(queryItems: [.init(name: "book", value: "btc_mxn")]), session: URLSession(configuration: .default)))))
}
