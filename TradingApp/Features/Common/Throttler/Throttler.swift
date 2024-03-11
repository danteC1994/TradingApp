//
//  Throttler.swift
//  TradingApp
//
//  Created by dante canizo on 11/03/2024.
//

import Combine
import Foundation

struct Throttler: Throttable {
    func throttle(
        every interval: TimeInterval,
        on runLoop: RunLoop,
        in mode: RunLoop.Mode,
        action: @escaping () async -> Void
    ) -> AnyCancellable {
        Timer.publish(every: interval, on: runLoop, in: mode)
            .autoconnect()
            .sink { _ in
                Task {
                    await action()
                }
            }
    }
}
