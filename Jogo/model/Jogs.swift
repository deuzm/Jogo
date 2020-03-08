//
//  Jogs.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/7/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation
import CoreData

class Jogs {
    
    static let shared = Jogs(jogs: [], user_id: 0)
    
    var jogs: [NSManagedObject]
    
    var user_id: Int
    
    private init(jogs: [NSManagedObject], user_id: Int) {
        self.jogs = jogs
        self.user_id = user_id
    }
}

