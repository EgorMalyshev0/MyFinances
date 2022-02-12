//
//  TransactionsViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 09.02.2022.
//

import SwiftUI
import RealmSwift

class TransactionsViewModel: ObservableObject {
    @ObservedRealmObject var transactionsGroup: TransactionGroup
    @ObservedRealmObject var accountsGroup: AccountGroup
    
    init(transactionsGroup: TransactionGroup, accountsGroup: AccountGroup) {
        self.transactionsGroup = transactionsGroup
        self.accountsGroup = accountsGroup
    }
}
