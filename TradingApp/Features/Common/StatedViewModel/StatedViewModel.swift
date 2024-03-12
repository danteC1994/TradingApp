//
//  StatedViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 12/03/2024.
//

protocol StatedViewModel {
    associatedtype S: Equatable
    associatedtype E: Equatable

    var state: ViewModelState<S, E> { get }
}
