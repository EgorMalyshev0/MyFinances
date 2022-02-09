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
                let account = Account()
                account.name = accountName
                account.balance = Double(balance) ?? 0
                account.type = accountType.rawValue
                $accountsViewModel.accountGroup.accounts.append(account)
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
