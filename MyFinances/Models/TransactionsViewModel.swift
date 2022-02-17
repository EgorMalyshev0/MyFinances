//
//  TransactionsViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 09.02.2022.
//

import SwiftUI
import RealmSwift

class TransactionsViewModel: ObservableObject {
    @ObservedRealmObject var accountsGroup: AccountGroup

    init(accountsGroup: AccountGroup) {
        self.accountsGroup = accountsGroup
    }
}
