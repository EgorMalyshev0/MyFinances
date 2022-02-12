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
    @Persisted var balance: Double
    @Persisted var transactions = RealmSwift.List<Transaction>()
    
    var bal: Double {
        let balances = transactions.map({$0.amount})
        return balance + balances.reduce(0) {$0 + $1}
    }
}

final class AccountGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var accounts = RealmSwift.List<Account>()
}
