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
    let subtitleColor: Color = .secondary

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subtitle)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(subtitleColor)
        }
    }
}

#Preview {
    RowView(title: "Volume", subtitle: "3500000")
}
