//
//  SelectIconScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.07.2022.
//

import SwiftUI

struct SelectIconScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var columns = [GridItem(.adaptive(minimum: 50))]
    @Binding var iconName: String
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(CategoryManager.iconNames, id: \.self) { iconName in
                    Image(systemName: iconName)
                        .onTapGesture {
                            self.iconName = iconName
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .padding()
        }
    }
}
