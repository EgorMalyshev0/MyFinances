//
//  TransactionRow.swift
//  MyFinances
//
//  Created by Egor Malyshev on 09.02.2022.
//

import SwiftUI

struct TransactionRow: View {
    
    var transaction: Transaction
    
    var amountText: String {
        if transaction.type == .expense {
            return "-\(transaction.amount.currencyString())"
        } else if transaction.type == .income {
            return "+\(transaction.amount.currencyString())"
        }
        return "\(transaction.amount.currencyString())"
    }
    
    var color: Color {
        if transaction.type == .expense {
            return .red
        } else if transaction.type == .income {
            return .green
        }
        return .primary
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                if transaction.type == .transfer {
                    Text(transaction.account?.name ?? "")
                        .foregroundColor(.primary)
                        .font(.body)
                    Text(transaction.targetAccount?.name ?? "")
                        .foregroundColor(.primary)
                        .font(.body)
                } else {
                    Text(transaction.category?.name ?? "Без категории")
                        .foregroundColor(.primary)
                        .font(.body)
                    Text(transaction.account?.name ?? "")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
            Spacer()
            Text(amountText)
                .multilineTextAlignment(.trailing)
                .foregroundColor(color)
        }
        .padding(.vertical, 3)
    }
}
