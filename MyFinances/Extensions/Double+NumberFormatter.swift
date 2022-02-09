//
//  Double+NumberFormatter.swift
//  MyFinances
//
//  Created by Egor Malyshev on 08.02.2022.
//

import Foundation

extension Double {
    func currencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
