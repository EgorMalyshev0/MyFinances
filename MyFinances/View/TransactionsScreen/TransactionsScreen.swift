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
                    ForEach(transactions.filter({$0.date.isEqualTo(date)})) { transaction in
                        NavigationLink  {
                            AddTransactionScreen(viewModel: AddTransactionScreenViewModel(transaction: transaction))
                        } label: {
                            TransactionRow(transaction: transaction)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(InsetListStyle())
        .toolbar {
            if viewModel.accountsExist() {
                NavigationLink {
                    AddTransactionScreen(viewModel: AddTransactionScreenViewModel())
                } label: {
                    Image(systemName: "plus")
                }
            } else {
                Button {
                    showingAlert = true
                } label: {
                    Image(systemName: "plus")
                }
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
