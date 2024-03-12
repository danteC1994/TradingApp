//
//  ThrottlerMock.swift
//  TradingAppTests
//
//  Created by dante canizo on 11/03/2024.
//

@testable import TradingApp
import Foundation
import Combine

struct ThrottlerMock: Throttable {
    let action: () async -> Void

    init(action: @escaping () -> Void = {}) {
        self.action = action
    }

    func throttle(every interval: TimeInterval, on runLoop: RunLoop, in mode: RunLoop.Mode, action: @escaping () async -> Void) -> AnyCancellable {
        Just({"await self.action()"})
        .sink(receiveValue: {_ in
            Task {
                await self.action()
            }
        })
    }
}
