//
//  AddAccountScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI
import RealmSwift

struct AddAccountScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var accountName: String = ""
    @State var balance: String = ""
    @State var accountType: AccountType = .cash
    @ObservedResults(Account.self) var accounts

    var body: some View {
        List {
            TextField("Название", text: $accountName)
            BalanceRow(balance: $balance, title: "Текущий баланс")
            NavigationLink {
                SelectAccountTypeScreen(selectedType: $accountType)
            } label: {
                Text(accountType.textDescription)
            }
        }
        .toolbar {
            Button("Сохранить") {
                let account = Account()
                account.name = accountName
                account.startBalance = Double(balance) ?? 0
                account.type = accountType
                $accounts.append(account)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(accountName.isEmpty)
        }
        .accentColor(.green)
        .navigationTitle("Новый счет")
        .navigationBarTitleDisplayMode(.inline)
    }
}
