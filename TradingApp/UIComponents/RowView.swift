//
//  RowView.swift
//  TradingApp
//
//  Created by dante canizo on 10/03/2024.
//

import SwiftUI

struct RowView: View {
    let title: String
    let subtitle: String
    let subtitleColor: Color
    let alignment: Alignment

    init(title: String, subtitle: String, subtitleColor: Color = .secondary, alignment: Alignment = .leading) {
        self.title = title
        self.subtitle = subtitle
        self.subtitleColor = subtitleColor
        self.alignment = alignment
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: alignment)
                .lineLimit(1)
            Text(subtitle)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: alignment)
                .foregroundColor(subtitleColor)
                .lineLimit(3)
        }
    }
}

#Preview {
    RowView(title: "Volume", subtitle: "3500000")
}
