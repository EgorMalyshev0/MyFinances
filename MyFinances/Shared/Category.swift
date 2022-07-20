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

final class DefaultCategoryMaker {
    
    static func categories() -> [Category] {
        var categories: [Category] = .init()
        categories.append(contentsOf: expenseCategories())
        categories.append(contentsOf: incomeCategories())
        return categories
    }
    
    static func expenseCategories() -> [Category] {
        let names = [("Автомобиль", "car"), ("Дом", "house"), ("Здоровье", "heart"), ("Путешествия", "airplane.departure"), ("Развлечения", "gamecontroller"), ("Рестораны", "leaf")]
        var categories: [Category] = .init()
        names.forEach {
            let category = Category()
            category.name = $0.0
            category.iconName = $0.1
            category.transactionType = TransactionType.expense
            categories.append(category)
        }
        return categories
    }
    
    static func incomeCategories() -> [Category] {
        let names = [("Другое", "person"), ("Зарплата", "giftcard"), ("Подарки", "gift")]
        var categories: [Category] = .init()
        names.forEach {
            let category = Category()
            category.name = $0.0
            category.iconName = $0.1
            category.transactionType = TransactionType.income
            categories.append(category)
        }
        return categories
    }
}
