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
}
