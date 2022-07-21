//
//  SettingsScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.07.2022.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        List {
            Section {
                NavigationLink {
                    CategoriesScreen()
                } label: {
                    Text("Категории")
                }
            }
            Section {
                NavigationLink {
                    AddSiriShortcutScreen()
                } label: {
                    Text("Автоматизация")
                }
            }
        }
        .navigationTitle("Настройки")
        .navigationBarTitleDisplayMode(.inline)
    }
}
