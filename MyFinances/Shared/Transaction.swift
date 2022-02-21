//
//  Transaction.swift
//  MyFinances
//
//  Created by Egor Malyshev on 09.02.2022.
//

import Foundation
import RealmSwift

final class Transaction: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var type: TransactionType
    @Persisted(originProperty: "transactions") var account: LinkingObjects<Account>
    @Persisted var category: Category?
    @Persisted var amount: Double
    @Persisted var date: Date
}
