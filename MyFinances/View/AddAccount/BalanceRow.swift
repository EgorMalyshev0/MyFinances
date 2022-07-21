//
//  BalanceRow.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI

struct BalanceRow: View {
    
    @Binding var balance: String
    @State var title: String
    
    var body: some View {
        HStack {
            Text(title)
            TextField("0", text: $balance)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
        }
    }
}
