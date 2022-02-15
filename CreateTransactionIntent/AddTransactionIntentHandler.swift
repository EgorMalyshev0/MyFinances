//
//  AddTransactionIntentHandler.swift
//  CreateTransactionIntent
//
//  Created by Egor Malyshev on 14.02.2022.
//

import Foundation
import Intents

public class AddTransactionIntentHandler: NSObject, AddTransactionIntentHandling {
    
    func handle(intent: AddTransactionIntent, completion: @escaping (AddTransactionIntentResponse) -> Void) {
        guard let amount = intent.amount,
            let dateComponents = intent.date,
            let categoryName = intent.category,
            let accountName = intent.account else {
                completion(AddTransactionIntentResponse(code: .failure, userActivity: nil))
                return
            }
        let transaction = Transaction()
        transaction.typeId = TransactionType.expense.rawValue
        transaction.date = Calendar.current.date(from: dateComponents) ?? Date()
        transaction.amount = -(Double(truncating: amount))
        let transactionManager = TransactionManager()
        guard transactionManager.updateCategory(withName: categoryName, with: transaction),
              transactionManager.updateAccount(withName: accountName, with: transaction) else {
                  completion(AddTransactionIntentResponse(code: .failure, userActivity: nil))
                  return
              }
        completion(AddTransactionIntentResponse())
    }
    
    func resolveAmount(for intent: AddTransactionIntent, with completion: @escaping (AddTransactionAmountResolutionResult) -> Void) {
        if let amount = intent.amount {
            completion(AddTransactionAmountResolutionResult.success(with: Double(truncating: amount)))
        } else {
            completion(AddTransactionAmountResolutionResult.needsValue())
        }
    }
    
    func resolveCategory(for intent: AddTransactionIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let category = intent.category {
            completion(INStringResolutionResult.success(with: category))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveAccount(for intent: AddTransactionIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let account = intent.category {
            completion(INStringResolutionResult.success(with: account))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveDate(for intent: AddTransactionIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
        if let date = intent.date {
            completion(INDateComponentsResolutionResult.success(with: date))
        } else {
            completion(INDateComponentsResolutionResult.needsValue())
        }
    }

    func provideCategoryOptionsCollection(for intent: AddTransactionIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        let transactionManager = TransactionManager()
        let availableCategories = transactionManager.findStoredCategories().map({NSString(string: $0)})
        completion(INObjectCollection(items: availableCategories), nil)
    }
    
    func provideAccountOptionsCollection(for intent: AddTransactionIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        let transactionManager = TransactionManager()
        let availableAccounts = transactionManager.findStoredAccounts().map({NSString(string: $0)})
        completion(INObjectCollection(items: availableAccounts), nil)
    }
    
    
}
