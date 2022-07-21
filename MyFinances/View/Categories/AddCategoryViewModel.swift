//
//  AddCategoryViewModel.swift
//  MyFinances
//
//  Created by Egor Malyshev on 20.07.2022.
//

import Foundation
import RealmSwift

class AddCategoryViewModel: ObservableObject {
    
    private var category: Category
    @Published var categoryName: String = ""
    @Published var iconName: String = ""
    @Published var transactionType: TransactionType = .expense

    var isEditing: Bool {
        category.realm != nil
    }
    
    var saveButtonDisabled: Bool {
        categoryName.isEmpty
    }
    
    init(category: Category? = nil) {
        self.category = category ?? Category()
        categoryName = category?.name ?? ""
        iconName = category?.iconName ?? ""
        transactionType = category?.transactionType ?? .expense
    }
    
    func saveCategory() {
        if category.realm == nil {
            saveNewCategory()
        } else {
            updateCategory()
        }
    }
    
    func deleteCategory() {
        if let thawed = category.thaw(), let realm = thawed.realm {
            try! realm.write({
                realm.delete(thawed)
            })
        }
    }
    
    private func saveNewCategory() {
        category.name = categoryName
        category.iconName = iconName
        category.transactionType = transactionType
        let realm = try! Realm.init(configuration: Constants.realmConfig)
        try! realm.write({
            realm.add(category)
        })
    }
    
    private func updateCategory() {
        guard category.realm != nil else { return }
        if let thawed = category.thaw(), let realm = thawed.realm {
            try! realm.write({
                thawed.name = categoryName
                thawed.iconName = iconName
                thawed.transactionType = transactionType
            })
        }
    }
    
}
