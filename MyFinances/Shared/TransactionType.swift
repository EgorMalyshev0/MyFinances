//
//  TransactionType.swift
//  MyFinances
//
//  Created by Egor Malyshev on 09.02.2022.
//

import Foundation

enum TransactionType: Int, CaseIterable {
    case expense = 0
    case income
    
    var textDescription: String {
        switch self {
        case .expense:
            return "Расход"
        case .income:
            return "Доход"
        }
    }
}
