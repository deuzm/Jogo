//
//  RealmOperations.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/9/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation
import RealmSwift

class RealmOperations {
    
    func saveJogsToRealm(distance: Float,
                         date: Double,
                         time: Float,
                         id: String,
                         user_id: String) {
        let jog = Jog()
        if(jog.id == "") {
            jog.id = id
        }
        let dateFormatter = ISO8601DateFormatter()
        
        dateFormatter.formatOptions = [.withFullDate]
        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//        formatter.locale = Locale(identifier: "en_US")
//
//        print(formatter.string(from: Date(timeIntervalSinceReferenceDate: date)))
//
        let dddd = Date(timeIntervalSince1970: date)
        var dateString = dateFormatter.string(from: dddd)
//        var dateString = formatter.string(from: Date(timeIntervalSinceReferenceDate: date))
        dateString = dateString.replacingOccurrences(of: "-", with: ".")
        

        jog.user_id = user_id
        jog.time = time
        jog.date = dateString
        jog.distance = distance
        
        let user = User()
        user.jogs.append(jog)
        
        migration()
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(jog, update: .all)
        }
    }
    
    func saveUserToRealm(id: String,
                         email: String,
                         phone: String,
                         role: String,
                         first_name: String,
                         last_name: String) {
        setDefaultRealmForUser(username: id)
        let user = User()
        if(user.id == "") {
            user.id = id
        }
        user.email = email
        user.phone = phone
        user.role = role
        user.first_name = first_name
        user.last_name = last_name
        
        migration()
        let realm = try! Realm()
        
        
        try! realm.write {
            realm.add(user, update: .modified)
        }
        
    }
    
    func setDefaultRealmForUser(username: String) {
        var config = Realm.Configuration()

        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username).realm")

        Realm.Configuration.defaultConfiguration = config
    }
    private func migration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
    
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
    
}
