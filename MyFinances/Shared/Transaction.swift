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
    @Persisted var typeId: Int
    @Persisted(originProperty: "transactions") var account: LinkingObjects<Account>
    @Persisted var categoryObjectId: ObjectId?
    @Persisted var categoryName: String?
    @Persisted var amount: Double
    @Persisted var date: Date
}

final class TransactionGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var transactions = RealmSwift.List<Transaction>()
}
