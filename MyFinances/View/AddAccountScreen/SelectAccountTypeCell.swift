//
//  SelectAccountTypeCell.swift
//  MyFinances
//
//  Created by Egor Malyshev on 08.02.2022.
//

import SwiftUI

struct SelectAccountTypeCell: View {
    @Environment(\.presentationMode) var presentationMode
    let type: AccountType
    @Binding var selectedType: AccountType
    
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
            self.selectedType = self.type
            presentationMode.wrappedValue.dismiss()
        }
    }
}
