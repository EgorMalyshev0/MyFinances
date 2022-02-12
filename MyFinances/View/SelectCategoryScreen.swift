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
    @State var transactionTypeId: Int
    
    @Binding var selectedCategory: Category?
    
    var body: some View {
        List(categories.filter({$0.transactionTypeId == transactionTypeId}), id: \.self) { category in
            SelectCategoryRow(category: category, selectedCategory: $selectedCategory)
        }
        .accentColor(.green)
    }
}
