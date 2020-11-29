//
//  RealmMigrationService.swift
//  unsplashapp
//
//  Created by admin on 17.11.2020.
//  Copyright © 2020 ivanfomenko. All rights reserved.
//


import Foundation
import RealmSwift

class RealmMigrationService {
    
    private var schemaVersion: String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    func performMigration() {
        let rmConfig = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: UInt64(schemaVersion) ?? 0,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { _, _ in
                // Do nothing for now
            }
        )
        
        Realm.Configuration.defaultConfiguration = rmConfig
    }
}
