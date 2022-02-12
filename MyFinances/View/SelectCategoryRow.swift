//
//  SelectCategoryRow.swift
//  MyFinances
//
//  Created by Egor Malyshev on 10.02.2022.
//

import SwiftUI

struct SelectCategoryRow: View {
    
    let category: Category
    @Binding var selectedCategory: Category?
    
    var body: some View {
        HStack {
            Text(category.name)
            Spacer()
            Image(systemName: "checkmark")
                .foregroundColor(.accentColor)
                .opacity(category == selectedCategory ? 1 : 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedCategory = self.category
        }
    }
}
