//
//  AddTransactionScreenViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 19.07.2022.
//

import Foundation
import Intents

class AddTransactionScreenViewModel: ObservableObject {
        
    private let transaction: Transaction
    @Published var amount: String = ""
    @Published var selectedTransactionType: TransactionType = .expense
    @Published var selectedCategory: Category?
    @Published var selectedAccount: Account?
    @Published var selectedDate: Date = Date()
    
    init(transaction: Transaction? = nil) {
        self.transaction = transaction ?? Transaction()
        guard let transaction = transaction else { return }
        amount = "\(transaction.amount)"
        selectedTransactionType = transaction.type
        selectedCategory = transaction.category
        selectedAccount = transaction.account.first
        selectedDate = transaction.date
    }
    
    func saveTransaction() {
        if transaction.realm == nil {
            saveNewTransaction()
        } else {
            updateTransaction()
        }
    }
    
    func makeDonation() {
        let intent = AddTransactionIntent()
        switch transaction.type {
        case .expense:
            intent.transactionType = .expense
        case .income:
            intent.transactionType = .income
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
    
    // MARK: - Private
    private func saveNewTransaction() {
        transaction.amount = Double(amount) ?? 0
        transaction.type = selectedTransactionType
        transaction.date = selectedDate
        if let thawed = selectedAccount?.thaw(), let realm = thawed.realm {
            if let account = realm.object(ofType: Account.self, forPrimaryKey: selectedAccount?._id),
               let category = realm.object(ofType: Category.self, forPrimaryKey: selectedCategory?._id){
                try! realm.write({
                    account.transactions.append(transaction)
                    transaction.category = category
                })
            }
        }
    }
    
    private func updateTransaction() {
        if let thawed = transaction.thaw(), let realm = thawed.realm {
            if let category = realm.object(ofType: Category.self, forPrimaryKey: selectedCategory?._id){
                try! realm.write({
                    thawed.amount = Double(amount) ?? 0
                    thawed.type = selectedTransactionType
                    thawed.date = selectedDate
                    thawed.category = category
                })
            }
        }
        if transaction.account.first?._id != selectedAccount?._id {
            if let thawed = transaction.thaw(),
               let realm = thawed.realm,
               let oldAcc = realm.object(ofType: Account.self, forPrimaryKey: transaction.account.first?._id),
               let newAcc = realm.object(ofType: Account.self, forPrimaryKey: selectedAccount?._id) {
                let transactions = oldAcc.transactions
                if let index = transactions.firstIndex(of: thawed) {
                    try! realm.write({
                        transactions.remove(at: index)
                        newAcc.transactions.append(thawed)
                    })
                }
            }
        }
    }
}
