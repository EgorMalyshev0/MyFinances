//
//  TransactionsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 06.02.2022.
//

import SwiftUI

struct TransactionsScreen: View {
    
    @ObservedObject var transactionsViewModel: TransactionsViewModel
    @State private var addTransactionIsPresented: Bool = false
    
    var body: some View {
        List {
            ForEach(transactions()) {
                TransactionRow(transaction: $0)
            }
//            .onDelete(perform: $transactionsViewModel.transactionsGroup.transactions.remove)
        }
        .toolbar {
            Button {
                addTransactionIsPresented = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $addTransactionIsPresented) {
            NavigationView{
                AddTransactionScreen()
                    .environmentObject(transactionsViewModel)
            }
        }
        .navigationTitle("Операции")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func transactions() -> [Transaction] {
        var transactions: [Transaction] = .init()
        transactionsViewModel.accountsGroup.accounts.forEach { account in
            transactions.append(contentsOf: account.transactions)
        }
        return transactions.sorted(by: {$0.date > $1.date})
    }
}
