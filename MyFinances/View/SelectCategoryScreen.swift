//
//  SelectCategoryScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 10.02.2022.
//

import SwiftUI
import RealmSwift

struct SelectCategoryScreen: View {
    
    @ObservedResults(Category.self) var categories
    @State var transactionType: TransactionType
    
    @Binding var selectedCategory: Category?
    
    var body: some View {
        List(categories.filter({$0.transactionType == transactionType}), id: \.self) { category in
            SelectCategoryRow(category: category, selectedCategory: $selectedCategory)
        }
        .accentColor(.green)
        .navigationTitle("Категории")
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "plus")
            }

        }
    }
        
}
