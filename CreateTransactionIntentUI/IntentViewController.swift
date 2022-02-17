//
//  IntentViewController.swift
//  CreateTransactionIntentUI
//
//  Created by Egor Malyshev on 14.02.2022.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
        
    // MARK: - INUIHostedViewControlling
    
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        guard let intent = interaction.intent as? AddTransactionIntent else {
            completion(false, Set(), .zero)
            return
        }
            categoryLabel.text = intent.category
            accountLabel.text = intent.account
            dateLabel.text = Calendar.current.date(from: intent.date ?? DateComponents())?.dateString
            amountLabel.text = Double(truncating: intent.amount ?? 0).currencyString()
            completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        let width = self.extensionContext!.hostedViewMaximumAllowedSize.width
        return CGSize(width: width, height: 80)
    }
    
}
