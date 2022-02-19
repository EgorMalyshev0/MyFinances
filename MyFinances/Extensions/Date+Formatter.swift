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
            if calendar.isDate(self, equalTo: Date(), toGranularity: .year) {
                formatter.dateFormat = "d MMMM, EE"
            } else {
                formatter.dateFormat = "d MMMM yyyy, EE"
            }
            return formatter.string(from: self)
        }
    }
    
    func isEqualTo(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return  calendar.isDate(self, equalTo: date, toGranularity: .day) &&
                calendar.isDate(self, equalTo: date, toGranularity: .month) &&
                calendar.isDate(self, equalTo: date, toGranularity: .year)
    }
}
