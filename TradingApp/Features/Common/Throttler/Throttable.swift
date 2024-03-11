//
//  Throttable.swift
//  TradingApp
//
//  Created by dante canizo on 11/03/2024.
//

import Combine
import Foundation

protocol Throttable {
    func throttle(
        every interval: TimeInterval,
        on runLoop: RunLoop,
        in mode: RunLoop.Mode,
        action: @escaping () async -> Void
    ) -> AnyCancellable
}
