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
 
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "en_US")
        var dateString = formatter.string(from: Date(timeIntervalSince1970: date))
//        print(dateString)
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
            schemaVersion: 1,
    
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
    
}
