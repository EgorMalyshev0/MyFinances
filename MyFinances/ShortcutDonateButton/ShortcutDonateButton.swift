//
//  ShortcutDonateButton.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.02.2022.
//

import SwiftUI
import Intents

public struct DonateButton: UIViewControllerRepresentable {
    public var intent: INIntent
    
    public init(intent: INIntent) {
        self.intent = intent
    }
        
    public func makeUIViewController(context: Context) -> DonateViewController {
        let controller = DonateViewController()
        controller.intent = intent
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: DonateViewController, context: Context) { }
}
