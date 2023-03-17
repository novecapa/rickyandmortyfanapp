//
//  RealmHelper.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation
import RealmSwift

class RealmHelper {

    static func applyMigrations() {
        var config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { _, _ in
            },
            shouldCompactOnLaunch: {totalBytes, usedBytes in
                // totalBytes refers to the size of the file on disk in bytes (data + free space)
                // usedBytes refers to the number of bytes used by data in the file

                // Compact if the file is over 30MB in size and less than 50% 'used'
                let oneHundredMB = 30 * 1024 * 1024
                return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
            })
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
    }
}
