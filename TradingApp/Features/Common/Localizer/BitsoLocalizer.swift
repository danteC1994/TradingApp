//
//  BitsoLocalizer.swift
//  TradingApp
//
//  Created by dante canizo on 10/03/2024.
//

import Foundation

struct BitsoLocalizer: Localizer {
    func priceLocalized(price: Double, locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        
        return formatter.string(from: NSNumber(value: price))
    }

    func decimalLocalized(_ number: Double, locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale

        return formatter.string(from: NSNumber(value: number))
    }
}
