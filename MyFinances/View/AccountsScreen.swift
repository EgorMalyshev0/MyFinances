//
//  AccountsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 06.02.2022.
//

import SwiftUI
import RealmSwift

struct AccountsScreen: View {
    
    @State private var addAccountIsPresented: Bool = false
    @State private var showingAlert = false
    @State var indexSet: IndexSet?
    
    @ObservedResults(Account.self) var accounts

    private var balance: Double {
        let balances = accounts.map({$0.balance})
        return balances.reduce(0) {$0 + $1}
    }
    
    private var balanceString: String {
        accounts.isEmpty ? "Нет счетов" : "Баланс: \(balance.currencyString())"
    }
    
    var body: some View {
        List {
            ForEach(accounts) {
                AccountCell(account: $0)
            }
            .onDelete { indexSet in
                self.indexSet = indexSet
                showingAlert = true
            }
        }
        .toolbar {
            Button {
                addAccountIsPresented = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $addAccountIsPresented) {
            NavigationView{
                AddAccountScreen()
            }
        }
        .navigationTitle(balanceString)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Вы действительно хотите удалить счет?", isPresented: $showingAlert, actions: {
            Button("Удалить", role: .destructive) {
                if let indexSet = indexSet {
                    let acc = accounts[indexSet.first ?? 0]
                    deleteTransactionsFromAccount(acc)
                    $accounts.remove(atOffsets: indexSet)
                }
            }
            Button("Отмена", role: .cancel) {}
        }, message: {
            Text("ВНИМАНИЕ! При удалении счета удалятся все привязанные к нему операции")
        })
    }
    
    func deleteTransactionsFromAccount(_ account: Account) {
        if let thawed = accounts.thaw(),
           let realm = thawed.realm,
           let acc = realm.object(ofType: Account.self, forPrimaryKey: account._id) {
            let transactions = acc.transactions
            try! realm.write({
                realm.delete(transactions)
            })
        }
    }
}
