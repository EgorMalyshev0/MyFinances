//
//  Category.swift
//  MyFinances
//
//  Created by Egor Malyshev on 10.02.2022.
//

import RealmSwift
import Foundation

final class Category: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var iconName: String
    @Persisted var transactionType: TransactionType
}

final class CategoryGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var categories = RealmSwift.List<Category>()
}
