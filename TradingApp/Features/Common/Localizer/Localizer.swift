//
//  Localizer.swift
//  TradingApp
//
//  Created by dante canizo on 10/03/2024.
//

import Foundation

protocol Localizer {
    func priceLocalized(price: Double, locale: Locale) -> String?
    func decimalLocalized(_ number: Double, locale: Locale) -> String?
}
