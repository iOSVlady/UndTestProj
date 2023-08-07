//
//  ios_UndControlApp.swift
//  ios-UndControlApp
//
//  Created by Vladyslav Romaniv on 02.07.2023.
//

import SwiftUI
import RealmSwift

@main
struct UndControlApp: SwiftUI.App {
    
    init() {
        setupRealmConfiguration()
    }

    var body: some Scene {
        WindowGroup {
            MainScreenView()
        }
    }
    
    
    func setupRealmConfiguration() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Perform any additional migration steps that are required.
                }
        })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config

        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        do {
            let _ = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
}
