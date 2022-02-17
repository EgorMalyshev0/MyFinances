//
//  Date+Formatter.swift
//  MyFinances
//
//  Created by Egor Malyshev on 13.02.2022.
//

import Foundation

extension Date {
    var dateString: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Сегодня"
        } else if calendar.isDateInYesterday(self) {
            return "Вчера"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.dateFormat = "d MMMM yyyy"
            return formatter.string(from: self)
        }
    }
}
