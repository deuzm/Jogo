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
    
    static let shared = Jogs(jogs: [])
    
    var jogs: [NSManagedObject]
    
    private init(jogs: [NSManagedObject]) {
        self.jogs = jogs
    }
}

