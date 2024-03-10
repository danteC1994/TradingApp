//
//  GenericErrorView.swift
//  TradingApp
//
//  Created by dante canizo on 10/03/2024.
//

import SwiftUI

struct GenericErrorView: View {
    let title: String
    let subtitle: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .secondary, radius: 10)
                HStack(alignment: .top) {
                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 100, height: 100)
                        Button(action: {
                            retryAction()
                        }, label: {
                            RowView(title: title, subtitle: subtitle, alignment: .center)
                        })
                        Spacer()
                    }
                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GenericErrorView(title: "Description", subtitle: "Generic error", retryAction: {})
}
