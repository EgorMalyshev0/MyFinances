//
//  AddTransactionScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 07.02.2022.
//

import SwiftUI

struct AddTransactionScreen: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Dismiss"){
            presentationMode.wrappedValue.dismiss()
        }
        .navigationTitle("Новая операция")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddTransactionScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionScreen()
    }
}
