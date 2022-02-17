//
//  AddTransactionScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI
import RealmSwift
import Intents

struct AddTransactionScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var transactionsViewModel: TransactionsViewModel
    @State var amount: String = ""
    @State var selectedTransactionTypeId: Int = 0
    @State var selectedCategory: Category?
    @State var selectedAccount: Account?
    @State var selectedDate: Date = Date()
    @ObservedResults(Category.self) var categories

    
    private var transactionTypes: [TransactionType] = TransactionType.allCases

    var body: some View {
        VStack {
            Picker("Выберите тип операции", selection: $selectedTransactionTypeId) {
                ForEach(0..<transactionTypes.count) { index in
                    Text(transactionTypes[index].textDescription)
                }
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedTransactionTypeId) { _ in
                selectedCategory = nil
            }
            List {
                BalanceRow(balance: $amount, title: "Сумма")
                NavigationLink {
                    SelectCategoryScreen(transactionTypeId: selectedTransactionTypeId, selectedCategory: $selectedCategory)
                } label: {
                    Text(selectedCategory?.name ?? "Выберите категорию")
                        .foregroundColor(selectedCategory == nil ? .secondary : .primary)
                }
                NavigationLink {
                    SelectAccountScreen(accountGroup: transactionsViewModel.accountsGroup, selectedAccount: $selectedAccount)
                } label: {
                    Text(selectedAccount?.name ?? "Выберите счет")
                        .foregroundColor(selectedAccount == nil ? .secondary : .primary)
                }
                DatePicker("Дата", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ru_RU"))
                    .labelsHidden()
            }
        }
        .toolbar {
            Button("Сохранить") {
                let transaction = Transaction()
                transaction.amount = Double(amount) ?? 0
                transaction.typeId = selectedTransactionTypeId
                transaction.date = selectedDate
                var accountName: String?
                var categoryName: String?
                if let thawed = transactionsViewModel.accountsGroup.thaw(), let realm = thawed.realm {
                    if let acc = realm.object(ofType: Account.self, forPrimaryKey: selectedAccount?._id) {
                        accountName = acc.name
                        try! realm.write({
                            acc.transactions.append(transaction)
                        })
                    }
                }
                if let thawed = categories.thaw(), let realm = thawed.realm, let cat = realm.object(ofType: Category.self, forPrimaryKey: selectedCategory?._id) {
                    categoryName = cat.name
                    try! realm.write({
                        cat.transactions.append(transaction)
                    })
                }
                if selectedTransactionTypeId == TransactionType.expense.rawValue {
                    makeDonation(transaction: transaction, accountName: accountName ?? "", categoryName: categoryName ?? "")
                }
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(amount.isEmpty || selectedCategory == nil || selectedAccount == nil)
        }
        .accentColor(.green)
        .navigationTitle("Новая операция")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func makeDonation(transaction: Transaction, accountName: String, categoryName: String) {
        let intent = AddTransactionIntent()
        intent.amount = NSNumber(value: transaction.amount)
        intent.date = Calendar.current.dateComponents([.year, .month, .day], from: transaction.date)
        intent.account = accountName
        intent.category = categoryName
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
