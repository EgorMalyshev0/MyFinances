//
//  AccountsViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 08.02.2022.
//

import SwiftUI

class AccountsViewModel: ObservableObject {
    @Published var accounts: [Account] = .init()
    
    var balance: Double {
        let balances = accounts.map({$0.balance})
        return balances.reduce(0) {$0 + $1}
    }
}
