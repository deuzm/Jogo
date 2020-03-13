//
//  LogInViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/5/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import SwiftyJSON

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - properties and outlets
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var letMeInButton: UIButton!
    @IBOutlet weak var idTextField: StyledTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationBar: BearNavigationBar!
    
    var request: AlamofireRequests = AlamofireRequests()
    var ok: Bool = false
    
    //MARK: - main view setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        self.idTextField.delegate = self
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUpViews() {
        let filterButton = navigationBar.viewWithTag(2) as? UIButton
        let menuButton = navigationBar.viewWithTag(3) as? UIButton
        menuButton?.isHidden = true
        filterButton?.isHidden = true
        

    }
    
    //MARK: - actions
    @IBAction func letMeInButtonTapped(_ sender: Any) {
       guard let text = idTextField.text, !text.isEmpty else {
            warningLabel.isHidden = false
            warningLabel.text = "Empty line, enter id"
            return
        }
        request.login(uuid: text) { (ok) in
            
            self.ok = ok
            if(self.ok) {
                print("molodec")
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
                DispatchQueue.global(qos: .background).async {
                    self.getUser()
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toHomePageSegue", sender: nil)
                        self.warningLabel.isHidden = true
                        self.activityIndicator.stopAnimating()
                    }
                }
                
            }
            else {
                self.warningLabel.isHidden = false
                self.warningLabel.text = "Wrong id, try again"
                self.warningLabel.textColor = .red
                self.warningLabel.isHidden = false
            }
        }
    }
    
    func getUser() {
        let ok: Bool
        AlamofireRequests().getCurrentUser() {
            (ok) in
            self.ok = ok
            if(ok) {
                AlertHelper().showErrorAlert(withMessage: "Could not get user", vc: self)
            }
        }
    }
    
    
    // MARK: - text field delegation functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        idTextField.text = ""
        idTextField.borderColor = .black
    }
     // MARK: - segue handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ok: Bool
        if let destination = segue.destination as? HomePageViewController {
            AlamofireRequests().getAndSaveJogs() {
                (ok) in
                self.ok = ok
                if(self.ok) {
                    
                }
            }
        }
    }
}

