//
//  alamofireRequests.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class AlamofireRequests {
    
    let baseURL = "https://jogtracker.herokuapp.com/api/v1/"
    
    func login(uuid: String, completion: @escaping(Bool) -> ())  {
        
    var ok = false
    let parameters = ["uuid":"\(uuid)"]
        
    AF.request("\(baseURL)auth/uuidLogin", method: .post, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case.success(let value) :
                let json = JSON(value)
                
                if let accessToken = json["response"]["access_token"].string {
                    if storage.addAccessToken(value: accessToken) {
                        ok = true
                        completion(ok)
                    }
                }
            case.failure(let error):
                print(error)
                ok = false
                completion(ok)
            }
        }
    }
    
    func getCurrentUser() {
        
        AF.request("\(baseURL)auth/user").responseJSON {
            response in
            switch response.result {
            case.success(let value) :
                let json = JSON(value)
                
                if let id = json["response"]["id"].string,
                    let email = json["response"]["email"].string,
                    let phone = json["response"]["phone"].string,
                    let role = json["response"]["role"].string,
                    let first_name = json["response"]["first_name"].string,
                    let last_name = json["response"]["last_name"].string
                {
                    self.saveUserToCoreData(id: id,
                                           email: email,
                                           phone: phone,
                                           role: role,
                                           first_name: first_name,
                                           last_name: last_name)
//                    Jogs.shared.user_id = Int(id) 
                }
                else {
                    debugPrint(json)
                }

            case.failure(let error) :
                print(error)
            }
        }
    }
    
    func addJog(distance: Float, time: Float, date: String, completion: @escaping(Bool) -> ()){
        
        var ok = false
        let parameters = [
            "distance":"\(distance)",
            "time":"\(time)",
            "date":"\(date)",
        ]
            
        AF.request("\(baseURL)data/jog", method: .post, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case.success(let value) :
                let json = JSON(value)
                debugPrint(json)
            case.failure(let error):
                print(error)
                ok = false
                completion(ok)
            }
        }
    }
    
    func getJogs() {
        AF.request("\(baseURL)data/sync").responseJSON {
            response in
            switch response.result {
            case.success(let value) :
                let json = JSON(value)
                if let jogs = json["response"]["jogs"].array {
                    for jog in jogs {
                        if jog["user_id"].string! == "3" {
                            if let distance = jog["distance"].int,
                            let id = jog["id"].int,
                            let date = jog["date"].int,
                            let time = jog["time"].int,
                                let user_id = jog["user_id"].string {
                                self.saveJogsToCoreData(distance: Float(distance), date: String(date), time: Float(time), id: Int64(id), user_id: user_id)
                            }
                        }
                    }
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func saveUserToCoreData(id: String, email: String, phone: String, role: String, first_name: String, last_name: String) {
        //adding to core data
        var users: [NSManagedObject] = []
        guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
        }

        let managedContext =
        appDelegate.persistentContainer.viewContext

        let entity =
        NSEntityDescription.entity(forEntityName: "User",
                                   in: managedContext)!

        let user = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

        // 3
        user.setValue(id, forKeyPath: "id")
        user.setValue(email, forKey: "email")
        user.setValue(phone, forKey: "phone")
        user.setValue(role, forKey: "role")
        user.setValue(first_name, forKey: "first_name")
        user.setValue(last_name, forKey: "last_name")


        // 4
        do {
        try managedContext.save()
        users.append(user)
        } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        }
        print("successfully added user")
    }
    
    private func saveJogsToCoreData(distance: Float, date: String, time: Float, id: Int64, user_id: String)  {
        
        guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity =
        NSEntityDescription.entity(forEntityName: "Jog",
                                   in: managedContext)!

        let user = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

        user.setValue(id, forKeyPath: "id")
        user.setValue(distance, forKey: "distance")
        user.setValue(time, forKey: "time")
        user.setValue(user_id, forKey: "user_id")
        
        do {
        try managedContext.save()
        Jogs.shared.jogs.append(user)
        } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        }
        print("successfully added user")
    }
}

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}
