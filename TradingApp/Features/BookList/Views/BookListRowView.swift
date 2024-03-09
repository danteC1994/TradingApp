//
//  BookListRowView.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import SwiftUI

struct BookListRowView: View {
    let book: Book
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.green)
            HStack {
                VStack(spacing: 16) {
                    Text(book.name)
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(book.maximumPrice)
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(book.maximumValue)
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(book.minimumValue)
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
            name: "BTC MXN",
            maximumPrice: "500000.00",
            maximumValue: "200000000.00",
            minimumValue: "10.00000000"
            
        )
    )
}
