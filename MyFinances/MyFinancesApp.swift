//
//  MyFinancesApp.swift
//  MyFinances
//
//  Created by Egor Malyshev on 05.02.2022.
//

import SwiftUI

@main
struct MyFinancesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, Constants.realmConfig)
        }
    }
}
