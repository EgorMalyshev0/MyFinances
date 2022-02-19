//
//  TransactionsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 06.02.2022.
//

import SwiftUI
import RealmSwift

struct TransactionsScreen: View {
    
    @State private var addTransactionIsPresented: Bool = false
    @ObservedResults(Transaction.self) var transactions

    var body: some View {
        List {
            ForEach(transactions) {
                TransactionRow(transaction: $0)
            }
            .onDelete(perform: $transactions.remove)
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
            }
        }
        .navigationTitle("Операции")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
