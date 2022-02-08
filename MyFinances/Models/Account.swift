//
//  Account.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import Foundation

struct Account: Identifiable {
    let name: String
    let type: AccountType
    let balance: Double
    let id: String = UUID().uuidString
}
