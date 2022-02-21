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
    @State var amount: String = ""
    @State var selectedTransactionType: TransactionType = .expense
    @State var selectedCategory: Category?
    @State var selectedAccount: Account?
    @State var selectedDate: Date = Date()
    @ObservedResults(Category.self) var categories

    var body: some View {
        VStack {
            Picker("Выберите тип операции", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases, id: \.self) {
                    Text($0.textDescription)
                        .tag($0)
                }
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedTransactionType) { _ in
                selectedCategory = nil
            }
            List {
                BalanceRow(balance: $amount, title: "Сумма")
                NavigationLink {
                    SelectCategoryScreen(transactionTypeId: selectedTransactionType.rawValue, selectedCategory: $selectedCategory)
                } label: {
                    Text(selectedCategory?.name ?? "Выберите категорию")
                        .foregroundColor(selectedCategory == nil ? .secondary : .primary)
                }
                NavigationLink {
                    SelectAccountScreen(selectedAccount: $selectedAccount)
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
                transaction.type = selectedTransactionType
                transaction.date = selectedDate
                if let thawed = categories.thaw(), let realm = thawed.realm {
                    if let account = realm.object(ofType: Account.self, forPrimaryKey: selectedAccount?._id),
                       let category = realm.object(ofType: Category.self, forPrimaryKey: selectedCategory?._id){
                        try! realm.write({
                            account.transactions.append(transaction)
                            transaction.category = category
                        })
                    }
                }
                makeDonation(transaction: transaction, accountName: selectedAccount?.name ?? "", categoryName: selectedCategory?.name ?? "")
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
        switch transaction.type {
        case .expense:
            intent.transactionType = .expense
        case .income:
            intent.transactionType = .income
        }
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
