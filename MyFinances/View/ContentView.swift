//
//  ContentView.swift
//  MyFinances
//
//  Created by Egor Malyshev on 05.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                AccountsScreen()
            }
            .tabItem {
                Image(systemName: "creditcard")
                Text("Счета")
            }
            .tag(0)
            NavigationView {
                TransactionsScreen()
                    .navigationTitle("Операции")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Операции")
            }
            .tag(1)
        }
        .accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}
