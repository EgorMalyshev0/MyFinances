//
//  SelectAccountScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 12.02.2022.
//

import SwiftUI
import RealmSwift

struct SelectAccountScreen: View {
    
    @ObservedResults(Account.self) var accounts

    @Binding var selectedAccount: Account?

    var body: some View {
        List(accounts) {
            SelectAccountRow(account: $0, selectedAccount: $selectedAccount)
        }
    }
}
