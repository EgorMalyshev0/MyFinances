//
//  TransactionType.swift
//  MyFinances
//
//  Created by Egor Malyshev on 09.02.2022.
//

import Foundation
import RealmSwift

enum TransactionType: Int, CaseIterable, PersistableEnum {
    case expense = 0
    case income
    case transfer
    
    var textDescription: String {
        switch self {
        case .expense:
            return "Расход"
        case .income:
            return "Доход"
        case .transfer:
            return "Перевод"
        }
    }
}
