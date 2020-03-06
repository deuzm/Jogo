//
//  ViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/2/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import OAuthSwift
import SwiftyJSON
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters = ["uuid":"hello"]
        AF.request("https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin", method: .post, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case.success(let value) :
                let json = JSON(value)
                debugPrint(json)
                
                if let accessToken = json["response"]["access_token"].string {
                    if storage.addAccessToken(value: accessToken) {
                        print(accessToken)
                    }
                }
            case.failure(let error):
                print(error)
            }


        }
        
        
        }
        // Do any additional setup after loading the view.
    }


