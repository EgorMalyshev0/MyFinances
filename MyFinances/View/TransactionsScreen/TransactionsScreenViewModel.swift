//
//  TransactionsScreenViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 18.07.2022.
//

import Foundation

class TransactionsScreenViewModel: ObservableObject {
    private let storageService: StorageService = .init()
    
    func accountsExist() -> Bool {
        return !storageService.findObjects(ofType: Account.self).isEmpty 
    }
}
