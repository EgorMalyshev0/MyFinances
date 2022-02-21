//
//  AccountType.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import Foundation
import RealmSwift

enum AccountType: String, CaseIterable, PersistableEnum {
    case cash
    case creditCard
    case bankAccount
    
    var textDescription: String {
        switch self {
        case .cash:
            return "Наличные"
        case .creditCard:
            return "Карта"
        case .bankAccount:
            return "Банковский счет"
        }
    }
}
