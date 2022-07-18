//
//  TransactionsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 06.02.2022.
//

import SwiftUI
import RealmSwift

struct TransactionsScreen: View {
    
    @ObservedObject var viewModel: TransactionsScreenViewModel = .init()
    
    @State private var addTransactionIsPresented: Bool = false
    @State private var showingAlert: Bool = false

    @ObservedResults(Transaction.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var transactions
    
    var dates: [Date] {
        var dates = [Date]()
        transactions.forEach {
            if dates.isEmpty || !$0.date.isEqualTo(dates.last ?? Date()) {
                dates.append($0.date)
            }
        }
        return dates
    }

    var body: some View {
        List {
            ForEach(dates, id: \.self) { date in
                Section(header: Text(date.dateString)) {
                    ForEach(transactions.filter({$0.date.isEqualTo(date)})) {
                        TransactionRow(transaction: $0)
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(InsetListStyle())
        .toolbar {
            Button {
                if viewModel.accountsExist() {
                    addTransactionIsPresented = true
                } else {
                    showingAlert = true
                }
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $addTransactionIsPresented) {
            NavigationView{
                AddTransactionScreen()
            }
        }
        .alert("У Вас нет счетов", isPresented: $showingAlert, actions: {
            Button("OK", role: .cancel) {}
                .accentColor(.green)
        }, message: {
            Text("Для добавления операции нужно добавить хотя бы один счет")
        })
        .navigationTitle("Операции")
        .navigationBarTitleDisplayMode(.inline)
    }
}
