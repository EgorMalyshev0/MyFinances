//
//  Constants.swift
//  MyFinances
//
//  Created by Egor Malyshev on 14.02.2022.
//

import Foundation
import RealmSwift

public struct Constants {
    public static let appGroupId: String = "group.com.egm.MyFinances"
    
    public static var realmPath: URL? {
        get {
            let directoryUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupId)
            return directoryUrl?.appendingPathComponent("realm.myFinances")
        }
    }
    
    public static var realmConfig: Realm.Configuration {
        get {
            var config = Realm.Configuration(fileURL: realmPath)
            config.deleteRealmIfMigrationNeeded = true
            return config
        }
    }
}
