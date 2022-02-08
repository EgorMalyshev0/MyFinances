//
//  AccountBalanceRow.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI

struct AccountBalanceRow: View {
    
    @Binding var balance: String
    
    var body: some View {
        HStack {
            Text("Текущий баланс")
            TextField("0", text: $balance)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
        }
    }
}
