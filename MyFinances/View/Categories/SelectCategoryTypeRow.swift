//
//  SelectCategoryTypeRow.swift
//  MyFinances
//
//  Created by Egor Malyshev on 21.07.2022.
//

import SwiftUI

struct SelectCategoryTypeRow: View {
    
    let type: TransactionType
    @Binding var selectedType: TransactionType
    
    var body: some View {
        HStack {
            Text(type.textDescription)
            Spacer()
            Image(systemName: "checkmark")
                .foregroundColor(.accentColor)
                .opacity(type == selectedType ? 1 : 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedType = type
        }
    }
}
