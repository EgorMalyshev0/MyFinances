//
//  CategoryManager.swift
//  MyFinances
//
//  Created by Egor Malyshev on 21.07.2022.
//

import Foundation

struct CategoryManager {
    
    static let iconNames: [String] = ["car", "house", "heart", "airplane.departure", "gamecontroller", "leaf", "person", "giftcard", "gift", "display", "iphone", "network", "icloud", "bus", "fuelpump", "drop", "bolt", "pencil", "scissors", "wand.and.rays", "paintbrush", "play", "bag", "cart", "clock", "alarm", "cross.case"]
    
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
