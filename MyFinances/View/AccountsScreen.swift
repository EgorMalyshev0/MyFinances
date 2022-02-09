//
//  AccountsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 06.02.2022.
//

import SwiftUI
import RealmSwift

struct AccountsScreen: View {
    
    @ObservedObject var accountsViewModel: AccountsViewModel
    @State private var addAccountIsPresented: Bool = false
    
    private var balanceString: String {
        accountsViewModel.accountGroup.accounts.isEmpty ? "Нет счетов" : "Баланс: \(accountsViewModel.balance.currencyString())"
    }
    
    var body: some View {
        List {
            ForEach(accountsViewModel.accountGroup.accounts) {
                AccountCell(account: $0)
            }
            .onDelete(perform: $accountsViewModel.accountGroup.accounts.remove)
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
                    .environmentObject(accountsViewModel)
            }
        }
        .navigationTitle(balanceString)
        .navigationBarTitleDisplayMode(.inline)
    }
}
