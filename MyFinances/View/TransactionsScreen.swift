//
//  TransactionsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 06.02.2022.
//

import SwiftUI

struct TransactionsScreen: View {
    
    @State private var addTransactionIsPresented: Bool = false
    
    var body: some View {
        Text("Мои транзакции")
            .toolbar {
                Button {
                    addTransactionIsPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $addTransactionIsPresented) {
                NavigationView{
                    AddTransactionScreen()
                }
            }
    }
}

struct TransactionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsScreen()
    }
}
