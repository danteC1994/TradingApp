//
//  BaseURL.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

public protocol BaseURL {
    var scheme: String { get }
    var host: String { get }
    var basePath: String { get }
}
