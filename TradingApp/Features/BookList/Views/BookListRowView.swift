//
//  BookListRowView.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import SwiftUI

struct BookListRowView: View {
    private let book: BookListViewData

    init(book: BookListViewData) {
        self.book = book
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.green)
            HStack {
                VStack(spacing: 16) {
                    Text(book.bookName)
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(book.maximumPrice)
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(book.values)
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading)
            }
            .padding()
        }
        .cornerRadius(8)
    }
}

#Preview {
    BookListRowView(
        book: .init(
            id: "btc_mxn",
            bookName: "BTC MXN",
            maximumPrice: "500000.00",
            values: "200000000.00 - 10.00000000"
        )
    )
}
