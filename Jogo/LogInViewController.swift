//
//  LogInViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/5/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class LogInViewController: UIViewController {

    
    @IBOutlet weak var letMeInButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    var request: AlamofireRequests = AlamofireRequests()
    
    var navigationBar: UINavigationBar = BearNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    func setUpViews() {
        navigationBar = BearNavigationBar()
        view.addSubview(navigationBar)

    }
    
    var ok: Bool = false
    
    @IBAction func letMeInButtonTapped(_ sender: Any) {
       guard let text = idTextField.text, !text.isEmpty else {
            return
        }
        request.login(uuid: text) { (ok) in
            self.ok = ok
            if(self.ok) {
                print("molodec")
                self.performSegue(withIdentifier: "toHomePageSegue", sender: nil)
            }
        }
    }
    
}
