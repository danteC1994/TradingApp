//
//  BookListViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Foundation

final class BookListViewModel: ObservableObject {
    enum State: Equatable {
        case idle(_ stateData: IdleStateData)
        case error
        case loading
    }

    struct IdleStateData: Equatable {
        let bookList: BookList
    }

    let service: BookListService

    @Published private(set) var state: State

    init(state: State, service: BookListService) {
        self.state = state
        self.service = service
    }

    @MainActor
    func requestBooks() async {
        let bookResponse = await service.getBooksRequestable.asyncGetrequest()
        switch bookResponse {
        case let .success(bookList):
            self.state = .idle(.init(bookList: bookList))
        case .failure:
            self.state = .error
        }
    }
}
