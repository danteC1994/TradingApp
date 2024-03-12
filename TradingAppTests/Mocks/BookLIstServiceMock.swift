//
//  BookLIstServiceMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 11/03/2024.
//

@testable import TradingApp
import Networking
import Foundation

struct BookListServiceSuccessMock: BookListServiceProtocol {
    func requestBooks() async -> Result<BookList, APIError> {
        .success(
            .init(
                books: [
                    .init(
                        name: "btc_mxn",
                        maximumPrice: "500000",
                        maximumValue: "200000000",
                        minimumValue: "10"
                    )
                ], success: true, error: nil
            )
        )
    }
}

struct BookListServiceURLErrorMock: BookListServiceProtocol {
    func requestBooks() async -> Result<BookList, APIError> {
        .failure(.url)
    }
}

struct BookListServiceNetworkErrorMock: BookListServiceProtocol {
    func requestBooks() async -> Result<BookList, APIError> {
        .failure(.network)
    }
}

struct BookListServiceDecodingErrorMock: BookListServiceProtocol {
    func requestBooks() async -> Result<BookList, APIError> {
        .failure(.decoding)
    }
}

class BookListServiceSuccesAndErrorWhenRetriessMock: BookListServiceProtocol {
    private var retried = false
    func requestBooks() async -> Result<BookList, APIError> {
        defer {
            retried = true
        }
        if retried { return .failure(.network) }
        return .success(
            .init(
                books: [
                    .init(
                        name: "btc_mxn",
                        maximumPrice: "500000",
                        maximumValue: "200000000",
                        minimumValue: "10"
                    )
                ], success: true, error: nil
            )
        )
    }
}
