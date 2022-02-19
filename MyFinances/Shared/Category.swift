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
    @Persisted var transactionTypeId: Int
}

final class CategoryGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var categories = RealmSwift.List<Category>()
}

final class DefaultCategoryMaker {
    
    static func categories() -> [Category] {
        var categories: [Category] = .init()
        categories.append(contentsOf: expenseCategories())
        categories.append(contentsOf: incomeCategories())
        return categories
    }
    
    static func expenseCategories() -> [Category] {
        let transactionTypeId = TransactionType.expense.rawValue
        let names = ["Автомобиль", "Дом", "Здоровье", "Путешествия", "Развлечения", "Рестораны"]
        var categories: [Category] = .init()
        names.forEach {
            let category = Category()
            category.name = $0
            category.transactionTypeId = transactionTypeId
            categories.append(category)
        }
        return categories
    }
    
    static func incomeCategories() -> [Category] {
        let transactionTypeId = TransactionType.income.rawValue
        let names = ["Другое", "Зарплата", "Подарки"]
        var categories: [Category] = .init()
        names.forEach {
            let category = Category()
            category.name = $0
            category.transactionTypeId = transactionTypeId
            categories.append(category)
        }
        return categories
    }
}
