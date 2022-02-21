//
//  MenuScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.02.2022.
//

import SwiftUI

struct MenuScreen: View {
    var body: some View {
        List {
            NavigationLink("Категории") {
                AddSiriShortcutScreen()
            }
            NavigationLink("Автоматизация") {
                AddSiriShortcutScreen()
            }
        }
        .navigationTitle("Меню")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
