//
//  Jog.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/8/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation
import RealmSwift

class Jog: Object {
    @objc dynamic var time: Float = 0
    @objc dynamic var distance: Float = 0
    @objc dynamic var date = ""
    @objc dynamic var id: String? = ""
    @objc dynamic var user_id = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

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
