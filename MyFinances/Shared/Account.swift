//
//  Account.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import Foundation
import RealmSwift

final class Account: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var type: AccountType
    @Persisted var startBalance: Double
    @Persisted var transactions = RealmSwift.List<Transaction>()
    
    var balance: Double {
        var balance = startBalance
        transactions.forEach {
            switch $0.type {
            case .expense:
                balance -= $0.amount
            case .income:
                balance += $0.amount
            case .transfer:
                if $0.targetAccount?.name == name {
                    balance += $0.amount
                } else {
                    balance -= $0.amount
                }
            }
        }
        return balance
    }
}
