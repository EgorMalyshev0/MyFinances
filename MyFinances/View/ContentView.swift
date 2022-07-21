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
                SettingsScreen()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Настройки")
            }
            .tag(2)
        }
        .accentColor(.green)
        .onAppear {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .green
            if categories.isEmpty {
                CategoryManager.categories().forEach({$categories.append($0)})
            }
        }
    }
    
}
