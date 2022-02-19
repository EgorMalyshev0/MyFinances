//
//  TransactionManager.swift
//  MyFinances
//
//  Created by Egor Malyshev on 14.02.2022.
//

import Foundation

final class TransactionManager {
    private let storageService: StorageService = .init()
    
    func findStoredCategories(withType type: TransactionType) -> [String] {
        let results = storageService.findObjects(ofType: Category.self)
        return results.filter({$0.transactionTypeId == type.rawValue}).map({$0.name})
    }
    
    func findStoredAccounts() -> [String] {
        let results = storageService.findObjects(ofType: Account.self)
        return results.map({$0.name})
    }
    
    @discardableResult
    func updateAccount(withName name: String, with transaction: Transaction) -> Bool {
        return storageService.updateAccount(withName: name, with: transaction)
    }
    
    func findCategoryWithName(_ name: String) -> Category? {
        return storageService.findObject(ofType: Category.self, byName: name)
    }
}
