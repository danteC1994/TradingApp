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
                    HStack(alignment: .top) {
                        VStack(spacing: 20) {
                            getRow(title: "Volume:", value: ticker.ticker.volume)
                            getRow(title: "High:", value: ticker.ticker.high)
                            getRow(title: "Price variation:", value: ticker.ticker.priceVariation)
                            Spacer()
                            if ticker.ticker.ask != nil || ticker.ticker.bid != nil {
                                Divider()
                                    .foregroundColor(.black)
                            }
                            getRow(title: "Ask:", value: ticker.ticker.ask)
                            getRow(title: "Bid:", value: ticker.ticker.bid)
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

    @ViewBuilder
    private func getRow(title: String, value: String?) -> some View {
        if let value {
            RowView(title: title, subtitle: value)
        }
        EmptyView()
    }
}

#Preview {
    TickerDetailsView(viewModel: .init(state: .idle(.init(ticker: .init(volume: "", high: "", priceVariation: "", ask: "", bid: ""))), service: .init(getTickerRequestable: .init(coder: JsonCoder(), endpoint: TickerEndpoint(queryItems: [.init(name: "book", value: "btc_mxn")]), session: URLSession(configuration: .default))), localizer: BitsoLocalizer()))
}
