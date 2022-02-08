//
//  AccountsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 06.02.2022.
//

import SwiftUI

struct AccountsScreen: View {
    
    @ObservedObject var accountsViewModel: AccountsViewModel = .init()
    @State private var addAccountIsPresented: Bool = false
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = " "
        return formatter
    }()
    private var balanceString: String {
        accountsViewModel.accounts.isEmpty ? "Нет счетов" : "Баланс: \(numberFormatter.string(from: NSNumber(value: accountsViewModel.balance)) ?? "")"
    }
    
    var body: some View {
        List(accountsViewModel.accounts) { account in
            HStack {
                Text(account.name)
                Spacer()
                Text(numberFormatter.string(from: NSNumber(value: account.balance)) ?? "")
                    .multilineTextAlignment(.trailing)
                    .frame(alignment: .trailing)
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
                    .environmentObject(accountsViewModel)
            }
        }
        .navigationTitle(balanceString)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AccountsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountsScreen()
    }
}
