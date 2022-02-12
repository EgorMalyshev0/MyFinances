//
//  AddTransactionScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI
import RealmSwift

struct AddTransactionScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var transactionsViewModel: TransactionsViewModel
    @State var amount: String = ""
    @State var selectedTransactionTypeIndex: Int = 0
    @State var selectedCategory: Category?
    @State var selectedAccount: Account?
    @ObservedResults(Category.self) var categories

    
    private var transactionTypes: [TransactionType] = TransactionType.allCases

    var body: some View {
        VStack {
            Picker("Выберите тип операции", selection: $selectedTransactionTypeIndex) {
                ForEach(0..<transactionTypes.count) { index in
                    Text(transactionTypes[index].textDescription)
                }
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedTransactionTypeIndex) { _ in
                selectedCategory = nil
            }
            List {
                BalanceRow(balance: $amount, title: "Сумма")
                NavigationLink {
                    SelectCategoryScreen(transactionTypeId: selectedTransactionTypeIndex, selectedCategory: $selectedCategory)
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
            }
        }
        .toolbar {
            Button("Сохранить") {
                let transaction = Transaction()
                switch selectedTransactionTypeIndex {
                case TransactionType.expense.rawValue:
                    transaction.amount = (-(Double(amount) ?? 0))
                case TransactionType.income.rawValue:
                    transaction.amount = Double(amount) ?? 0
                default:
                    break
                }
                transaction.typeId = selectedTransactionTypeIndex
                transaction.date = Date()
                if let thawed = transactionsViewModel.accountsGroup.thaw(), let realm = thawed.realm {
                    if let acc = realm.object(ofType: Account.self, forPrimaryKey: selectedAccount?._id) {
                        try! realm.write({
                            acc.transactions.append(transaction)
                        })
                    }
                }
                if let thawed = categories.thaw(), let realm = thawed.realm, let cat = realm.object(ofType: Category.self, forPrimaryKey: selectedCategory?._id) {
                    try! realm.write({
                        cat.transactions.append(transaction)
                    })
                }
                
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(amount.isEmpty || selectedCategory == nil || selectedAccount == nil)
        }
        .accentColor(.green)
        .navigationTitle("Новая операция")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
