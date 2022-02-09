//
//  AccountCell.swift
//  MyFinances
//
//  Created by Egor Malyshev on 08.02.2022.
//

import SwiftUI

struct AccountCell: View {
    
    var account: Account
    
    var body: some View {
        HStack {
            Text(account.name)
            Spacer()
            Text(account.balance.currencyString())
                .multilineTextAlignment(.trailing)
        }
    }
}

