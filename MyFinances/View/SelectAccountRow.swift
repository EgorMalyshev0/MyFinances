//
//  SelectAccountRow.swift
//  MyFinances
//
//  Created by Egor Malyshev on 12.02.2022.
//

import SwiftUI

struct SelectAccountRow: View {
    @Environment(\.presentationMode) var presentationMode

    let account: Account
    @Binding var selectedAccount: Account?
    
    var body: some View {
        HStack {
            Image(systemName: account.type.imageName)
                .frame(width: 35)
            Text(account.name)
            Spacer()
            Image(systemName: "checkmark")
                .foregroundColor(.accentColor)
                .opacity(account == selectedAccount ? 1 : 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedAccount = self.account
            presentationMode.wrappedValue.dismiss()
        }
    }
}
