//
//  ViewModelState.swift
//  TradingApp
//
//  Created by dante canizo on 12/03/2024.
//

import Foundation

enum ViewModelState<S, E>: Equatable where S: Equatable, E: Equatable {
    case idle(_ stateData: S)
    case error(_ stateData: E)
    case loading
    case empty
}
