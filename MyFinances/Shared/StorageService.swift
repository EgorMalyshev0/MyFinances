//
//  StorageService.swift
//  MyFinances
//
//  Created by Egor Malyshev on 14.02.2022.
//

import Foundation
import RealmSwift

final class StorageService {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm.init(configuration: Constants.realmConfig)
    }
    
    func findObjects<T: Object>(ofType type: T.Type) -> Results<T> {
        let results = self.realm.objects(type)
        return results
    }
    
    func findObject<T: Object>(ofType type: T.Type, byName name: String) -> T? {
        return self.realm.objects(T.self).filter("name == \(name)").first
    }
    
    func updateAccount(withName name: String, with transaction: Transaction) -> Bool {
        guard let account = findObject(ofType: Account.self, byName: name) else { return false }
        do {
            try realm.write {
                account.transactions.append(transaction)
            }
            return true
        } catch {
            return false
        }
    }
    
    func updateCategory(withName name: String, with transaction: Transaction) -> Bool {
        guard let category = findObject(ofType: Category.self, byName: name) else { return false }
        do {
            try realm.write {
                category.transactions.append(transaction)
            }
            return true
        } catch {
            return false
        }
    }
    
}
