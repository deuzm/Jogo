//
//  User.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/13/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id: String? = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var role = ""
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    var jogs = List<Jog>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
