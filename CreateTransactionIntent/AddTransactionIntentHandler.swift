//
//  AddTransactionIntentHandler.swift
//  CreateTransactionIntent
//
//  Created by Egor Malyshev on 14.02.2022.
//

import Foundation
import Intents
import os.log

public class AddTransactionIntentHandler: NSObject, AddTransactionIntentHandling {
    
    func handle(intent: AddTransactionIntent, completion: @escaping (AddTransactionIntentResponse) -> Void) {
        guard let amount = intent.amount,
            let dateComponents = intent.date,
            let categoryName = intent.category,
            let accountName = intent.account else {
                Logger().debug("INTENT DEBUG: FAILED TO HANDLE")
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
                  Logger().debug("INTENT DEBUG: FAILED TO HANDLE WITH TRANSACTION ADDING")
                  completion(AddTransactionIntentResponse(code: .failure, userActivity: nil))
                  return
              }
        completion(AddTransactionIntentResponse(code: .success, userActivity: nil))
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
        if let account = intent.account {
            completion(INStringResolutionResult.success(with: account))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveDate(for intent: AddTransactionIntent, with completion: @escaping (AddTransactionDateResolutionResult) -> Void) {
        guard let dateComponents = intent.date else {
            completion(AddTransactionDateResolutionResult.needsValue())
            return
        }
        guard let date = Calendar.current.date(from: dateComponents) else {
            completion(AddTransactionDateResolutionResult.unsupported())
            return
        }
        if date > Date()  {
            completion(AddTransactionDateResolutionResult.unsupported(forReason: .dateIsLaterThanToday))
        } else {
            completion(AddTransactionDateResolutionResult.success(with: dateComponents))
        }
    }

    func provideCategoryOptionsCollection(for intent: AddTransactionIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        let transactionManager = TransactionManager()
        let availableCategories = transactionManager.findStoredCategories(withType: .expense).map({NSString(string: $0)})
        completion(INObjectCollection(items: availableCategories), nil)
    }
    
    func provideAccountOptionsCollection(for intent: AddTransactionIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        let transactionManager = TransactionManager()
        let availableAccounts = transactionManager.findStoredAccounts().map({NSString(string: $0)})
        completion(INObjectCollection(items: availableAccounts), nil)
    }
    
    
}
