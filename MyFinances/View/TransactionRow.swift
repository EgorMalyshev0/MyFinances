//
//  TransactionRow.swift
//  MyFinances
//
//  Created by Egor Malyshev on 09.02.2022.
//

import SwiftUI

struct TransactionRow: View {
    
    var transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.category.first?.name ?? "Без категории")
                    .foregroundColor(.primary)
                    .font(.body)
                Text(transaction.account.first?.name ?? "")
                    .foregroundColor(.secondary)
                    .font(.caption)
                Text(transaction.date.dateString)
                    .foregroundColor(.secondary)
                    .font(.caption2)
            }
            Spacer()
            Text(transaction.amount.currencyString())
                .multilineTextAlignment(.trailing)
        }
    }
}
