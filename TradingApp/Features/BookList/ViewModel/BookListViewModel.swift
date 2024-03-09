//
//  BookListViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Foundation

final class BookListViewModel: ObservableObject {
    enum State {
        case idle(_ stateData: IdleStateData)
        case error
        case loading
    }

    struct IdleStateData {
        let bookName: String
        let maximumPrice: String
        let maximumValue: String
        let minimumValue: String
    }

    @Published private(set) var state: State

    init(state: State) {
        self.state = state
    }

}
