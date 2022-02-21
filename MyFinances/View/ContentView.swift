//
//  ContentView.swift
//  MyFinances
//
//  Created by Egor Malyshev on 05.02.2022.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State private var selection: Int = 0
    @ObservedResults(Category.self) var categories
    
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
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Операции")
            }
            .tag(1)
            NavigationView {
                MenuScreen()
            }
            .tabItem {
                Image(systemName: "line.3.horizontal")
                Text("Еще")
            }
            .tag(2)
        }
        .accentColor(.green)
        .onAppear {
            if categories.isEmpty {
                DefaultCategoryMaker.categories().forEach({$categories.append($0)})
            }
        }
    }
    
}
