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
                    text(title: book.bookName, font: .title)
                    text(title: book.maximumPrice, font: .body)
                    text(title: book.values, font: .body)
                }
                .padding(.leading)
            }
            .padding()
        }
        .cornerRadius(8)
    }

    private func text(title: String, font: Font) -> some View {
        Text(title)
            .foregroundColor(.black)
            .font(font)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BookListFactory.rowViewWithData()
}
