//
//  CategoriesScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.07.2022.
//

import SwiftUI
import RealmSwift

struct CategoriesScreen: View {
    
    @ObservedResults(Category.self) var categories
    @State var type: TransactionType = .expense
        
    var body: some View {
        VStack {
            Picker("", selection: $type) {
                ForEach([TransactionType.expense, TransactionType.income], id: \.self) {
                    Text($0.textDescription)
                        .tag($0)
                }
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            List {
                ForEach(categories.filter({$0.transactionType == type})) { category in
                    NavigationLink {
                        AddCategoryScreen(viewModel: AddCategoryViewModel(category: category))
                    } label: {
                        HStack {
                            Image(systemName: category.iconName)
                                .frame(width: 35)
                            Text(category.name)
                        }
                    }
                }
            }
        }
        .accentColor(.green)
        .navigationTitle("Категории")
        .toolbar {
            Button {
            } label: {
                NavigationLink {
                    AddCategoryScreen(viewModel: AddCategoryViewModel())
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
        
}
