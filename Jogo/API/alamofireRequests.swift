//
//  alamofireRequests.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation
//import Alamofire
import SwiftyJSON
//import RealmSwift


class AlamofireRequests {
    
    
    let baseURL = "https://jogtracker.herokuapp.com/api/v1/"
    
    func login(uuid: String, completion: @escaping(Bool) -> ())  {
        DispatchQueue.global(qos: .background).async {
        var ok = false
        let parameters = ["uuid":"\(uuid)"]
            
        AF.request("\(self.baseURL)auth/uuidLogin", method: .post, parameters: parameters).responseJSON {
                response in
                switch response.result {
                case.success(let value) :
                    let json = JSON(value)
                    if let accessToken = json["response"]["access_token"].string {
                        if storage.addAccessToken(value: accessToken) {
                            ok = true
                            completion(ok)
                        }
                    } else if let errorMessage = json["error_message"].string {
                        ok = false
                        completion(ok)
                    }
                case.failure(let error):
                    print(error)
                    ok = false
                    completion(ok)
                }
            }
        }
    }
    
    func getCurrentUser(completion: @escaping(Bool) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var ok = false
            AF.request("\(self.baseURL)auth/user").responseJSON {
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
                        RealmOperations().saveUserToRealm(id: id,
                                               email: email,
                                               phone: phone,
                                               role: role,
                                               first_name: first_name,
                                               last_name: last_name)
                        ok = true
                        completion(ok)
                        
                    } else if let errorMessage = json["error_message"].string {
                        ok = false
                        completion(ok)
                    }
                        
                    else {
                        debugPrint(json)
                        completion(ok)
                    }

                case.failure(let error) :
                    print(error)
                }
            }
        }
    }
        
    func addJog(distance: Float, time: Float, date: String, completion: @escaping(Bool) -> ()){
        DispatchQueue.global(qos: .background).async {
            var ok = false
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let ff = ISO8601DateFormatter()
            ff.formatOptions = [.withFullDate]
            let dateString = ff.string(from: formatter.date(from: date)!)
            print(dateString)
            let parameters = [
                "distance":"\(distance)",
                "time":"\(time)",
                "date":"\(dateString)",
            ]
                
            AF.request("\(self.baseURL)data/jog", method: .post, parameters: parameters).responseJSON {
                response in
                switch response.result {
                case.success(let value) :
                    let json = JSON(value)
                    if let errorMessage = json["error_message"].string {
                        ok = false
                        completion(ok)
                    }
                    print(json)
                    ok = true
                    completion(ok)
                case.failure(let error):
                    print(error)
                    ok = false
                    completion(ok)
                }
            }
        }
    }
    
    
    func updateJog(distance: Int, time: Float, date: String, jog_id: Int, user_id: String, completion: @escaping(Bool) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var ok = false
            let parameters = [
                "jog_id": "\(jog_id)",
                "user_id": "\(user_id)",
                "distance":"\(distance)",
                "time":"\(time)",
                "date":"\(date)"
            ]
            AF.request("\(self.baseURL)data/jog", method: .put, parameters: parameters).responseJSON {
                response in
                switch response.result {
                case.success(let value) :
                    let json = JSON(value)
                    if let errorMessage = json["error_message"].string {
                        ok = false
                        completion(ok)
                    }
                    ok = true
                    completion(ok)
                case.failure(let error):
                    print(error)
                    ok = false
                    completion(ok)
                }
            }
        }
    }
    
    func getAndSaveJogs(completion: @escaping(Bool) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var ok = false
            AF.request("\(self.baseURL)data/sync").responseJSON {
                response in
                switch response.result {
                case.success(let value) :
                    let json = JSON(value)
                    
                    if let jogs = json["response"]["jogs"].array {
                        for jog in jogs {
                            if jog["user_id"].string! == "3" {
                                if let distance = jog["distance"].float,
                                let id = jog["id"].int,
                                let date = jog["date"].double,
                                let time = jog["time"].float,
                                let user_id = jog["user_id"].string {
                                RealmOperations().saveJogsToRealm(distance: distance, date: date, time: time, id: String(id), user_id: user_id)
                                }
                            } else if let errorMessage = json["error_message"].string {
                                ok = false
                                completion(ok)
                            }
                        }
                    }
                    ok = true
                    completion(ok)
                    
                case.failure(let error):
                    print(error)
                    ok = false
                    completion(ok)
                }
            }
        }
        
    }
    
    func sendFeedback(topic_id: String, text: String, completion: @escaping(Bool) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var ok = false
            let parameters = [
                "topic_id": "\(topic_id)",
                "text": "\(text)"
            ]
            AF.request("\(self.baseURL)feedback/send", method: .post, parameters: parameters).responseJSON {
                response in
                switch response.result {
                case.success(let value) :
                    let json = JSON(value)
                    if let errorMessage = json["error_message"].string {
                        ok = false
                        completion(ok)
                    }
                    ok = true
                    completion(ok)
                    debugPrint(json)
                case.failure(let error):
                    print(error)
                    completion(ok)
                }
            }
        }
    }
    
    
}

