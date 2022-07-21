//
//  SelectAccountTypeScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI

struct SelectAccountTypeScreen: View {
    @Binding var selectedType: AccountType
    var types: [AccountType] = AccountType.allCases
    
    var body: some View {
        List(types, id: \.self) { type in
            SelectAccountTypeCell(type: type, selectedType: $selectedType)
        }
        .accentColor(.green)
        .navigationTitle("Тип счета")
    }
}
