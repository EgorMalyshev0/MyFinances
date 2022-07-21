//
//  AddSiriShortcutScreen.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.02.2022.
//

import SwiftUI

struct AddSiriShortcutScreen: View {
    var body: some View {
        VStack {
            Text("Вы можете автоматизировать добавление операций, добавив быструю команду для Siri")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            DonateButton(intent: AddTransactionIntent())
                .frame(maxHeight: 80)
        }
        .padding()
    }
}

struct AddSiriShortcutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddSiriShortcutScreen()
    }
}
