//
//  AccountsViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 08.02.2022.
//

import SwiftUI
import RealmSwift

class AccountsViewModel: ObservableObject {
    @ObservedRealmObject var accountGroup: AccountGroup
    
    var balance: Double {
        let balances = accountGroup.accounts.map({$0.bal})
        return balances.reduce(0) {$0 + $1}
    }
    
    init(accountGroup: AccountGroup) {
        self.accountGroup = accountGroup
    }
}
