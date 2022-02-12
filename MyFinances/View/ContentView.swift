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
    @ObservedResults(AccountGroup.self) var accountGroups
    @ObservedResults(TransactionGroup.self) var transactionGroups
    @ObservedResults(Category.self) var categories
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                if let group = accountGroups.first {
                    let viewModel = AccountsViewModel(accountGroup: group)
                    AccountsScreen(accountsViewModel: viewModel)
                } else {
                    ProgressView()
                        .onAppear {
                        $accountGroups.append(AccountGroup())
                    }
                }
            }
            .tabItem {
                Image(systemName: "creditcard")
                Text("Счета")
            }
            .tag(0)
            NavigationView {
                if let group = transactionGroups.first, let accGroup = accountGroups.first {
                    let viewModel = TransactionsViewModel(transactionsGroup: group, accountsGroup: accGroup)
                    TransactionsScreen(transactionsViewModel: viewModel)
                } else {
                    ProgressView()
                        .onAppear {
                        $transactionGroups.append(TransactionGroup())
                    }
                }        
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Операции")
            }
            .tag(1)
        }
        .accentColor(.green)
        .onAppear {
            if categories.isEmpty {
                DefaultCategoryMaker.categories().forEach({$categories.append($0)})
            }
        }
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
