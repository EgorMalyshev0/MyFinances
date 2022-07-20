//
//  AddTransactionScreenViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 19.07.2022.
//

import Foundation
import Intents
import RealmSwift

class AddTransactionScreenViewModel: ObservableObject {
        
    private var transaction: Transaction
    @Published var amount: String = ""
    @Published var selectedTransactionType: TransactionType = .expense
    @Published var selectedCategory: Category?
    @Published var selectedAccount: Account?
    @Published var selectedTargetAccount: Account?
    @Published var selectedDate: Date = Date()
    
    var isEditing: Bool {
        transaction.realm != nil
    }
    
    init(transaction: Transaction? = nil) {
        self.transaction = transaction ?? Transaction()
        guard let transaction = transaction else { return }
        amount = "\(transaction.amount)"
        selectedTransactionType = transaction.type
        selectedCategory = transaction.category
        selectedAccount = transaction.account
        selectedTargetAccount = transaction.targetAccount
        selectedDate = transaction.date
    }
    
    func saveTransaction() {
        if transaction.realm == nil {
            saveNewTransaction()
            makeDonation()
        } else {
            updateTransaction()
        }
    }
    
    func deleteTransaction() {
        _deleteTransaction()
    }
    
    func savingEnable() -> Bool {
        switch selectedTransactionType {
        case .expense, .income:
            return amount.isEmpty || selectedCategory == nil || selectedAccount == nil
        case .transfer:
            return amount.isEmpty || selectedAccount == nil || selectedTargetAccount == nil || selectedAccount == selectedTargetAccount
        }        
    }
    
    // MARK: - Private
    private func saveNewTransaction() {
        transaction.amount = Double(amount) ?? 0
        transaction.type = selectedTransactionType
        transaction.date = selectedDate
        let realm = try! Realm.init(configuration: Constants.realmConfig)
            try! realm.write({
                realm.add(transaction)
            })
            if let id = selectedCategory?._id, let category = realm.object(ofType: Category.self, forPrimaryKey: id) {
                try! realm.write({
                    transaction.category = category
                })
            }
            if let account = realm.object(ofType: Account.self, forPrimaryKey: selectedAccount?._id) {
                try! realm.write({
                    transaction.account = account
                    account.transactions.append(transaction)
                })
            }
            if let id = selectedTargetAccount?._id, let targetAccount = realm.object(ofType: Account.self, forPrimaryKey: id) {
                try! realm.write({
                    transaction.targetAccount = targetAccount
                    targetAccount.transactions.append(transaction)
                })
            }
    }
    
    private func _deleteTransaction() {
        if let thawed = transaction.thaw(), let realm = thawed.realm {
            try! realm.write({
                realm.delete(thawed)
            })
        }
    }
    
    private func updateTransaction() {
        _deleteTransaction()
        transaction = Transaction()
        saveNewTransaction()
    }
    
    private func makeDonation() {
        let intent = AddTransactionIntent()
        switch transaction.type {
        case .expense:
            intent.transactionType = .expense
        case .income:
            intent.transactionType = .income
        case .transfer:
            intent.transactionType = .transfer
        }
        intent.amount = NSNumber(value: transaction.amount)
        intent.date = Calendar.current.dateComponents([.year, .month, .day], from: transaction.date)
        intent.account = selectedAccount?.name
        intent.category = selectedCategory?.name
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if let error = error {
                print("Donation failed due to error: \(error.localizedDescription)")
            } else {
                print("Successfully donated interaction")
            }
        }
    }
}
