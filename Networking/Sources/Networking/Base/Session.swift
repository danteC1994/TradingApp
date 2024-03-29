//
//  Session.swift
//  TradingApp
//
//  Created by dante canizo on 09/03/2024.
//

import Foundation

protocol Session {
    func data(from url: URL) async throws -> (Data, URLResponse)
}
