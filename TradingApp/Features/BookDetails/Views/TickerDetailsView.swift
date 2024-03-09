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
        ZStack {
            Color.white
                .ignoresSafeArea()
            switch viewModel.state {
            case let .idle(ticker):
                Rectangle()
                    .foregroundColor(Color.secondary)
                    .cornerRadius(60)
                VStack{
                    VStack {
                        HStack {
                            VStack(spacing: 16) {
                                Text(ticker.ticker.ask)
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding(.leading)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
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
