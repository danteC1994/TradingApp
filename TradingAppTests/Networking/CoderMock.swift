//
//  CoderMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 09/03/2024.
//

@testable import TradingApp
import Foundation

struct CoderMock: Decoder {
    func decode<T>(data: Data, dataType: T.Type) -> T? where T : Decodable {
        return nil
    }
}
