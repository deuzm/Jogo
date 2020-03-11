//
//  LogInViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/5/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Alamofire


class LogInViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var letMeInButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    
    var request: AlamofireRequests = AlamofireRequests()
    
    var navigationBar: UINavigationBar = BearNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        self.idTextField.delegate = self
        
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

        //Create acivity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        

        //Position activity indicator
        view.addSubview(myActivityIndicator)
        
        myActivityIndicator.hidesWhenStopped = false
        
        myActivityIndicator.startAnimating()
        
        request.login(uuid: text) { (ok) in
            
            self.ok = ok
            if(self.ok) {
                print("molodec")
                self.getUser()
                self.performSegue(withIdentifier: "toHomePageSegue", sender: nil)
            }
        }
        removeActivityIndicator(activityIndicator: myActivityIndicator)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HomePageViewController {
            AlamofireRequests().getAndSaveJogs()
        }
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
         {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    func getUser() {
        AlamofireRequests().getCurrentUser()
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
