//
//  IntentHandler.swift
//  CreateTransactionIntent
//
//  Created by Egor Malyshev on 14.02.2022.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {

    override func handler(for intent: INIntent) -> Any {
        guard intent is AddTransactionIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        return AddTransactionIntentHandler()
    }
    
}
