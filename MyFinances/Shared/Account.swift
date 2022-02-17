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
    @Persisted var type: String
    @Persisted var startBalance: Double
    @Persisted var transactions = RealmSwift.List<Transaction>()
    
    var balance: Double {
        var balance = startBalance
        transactions.forEach {
            if $0.typeId == TransactionType.expense.rawValue {
                balance -= $0.amount
            } else if $0.typeId == TransactionType.income.rawValue {
                balance += $0.amount
            }
        }
        return balance
    }
}

final class AccountGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var accounts = RealmSwift.List<Account>()
}
