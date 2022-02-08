//
//  AddAccountScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI

struct AddAccountScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var accountsViewModel: AccountsViewModel
    @State var accountName: String = ""
    @State var balance: String = ""
    @State var accountType: AccountType = .cash

    var body: some View {
        List {
            TextField("Название", text: $accountName)
            AccountBalanceRow(balance: $balance)
            NavigationLink {
                SelectAccountTypeScreen(selectedType: $accountType)
            } label: {
                Text(accountType.textDescription)
            }
        }
        .toolbar {
            Button("Сохранить") {
                let account = Account(name: accountName, type: accountType, balance: Double(balance) ?? 0)
                accountsViewModel.accounts.append(account)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(accountName.isEmpty)
        }
        .accentColor(.green)
    }
}

struct AddAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountScreen()
    }
}
