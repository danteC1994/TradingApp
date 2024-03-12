//
//  StatedViewModel.swift
//  TradingApp
//
//  Created by dante canizo on 12/03/2024.
//

protocol StatedViewModel {
    associatedtype S: Equatable
    associatedtype E: Equatable

    /// S and E represents successful and error ViewModel state data respectively.
    var state: ViewModelState<S, E> { get }
}
