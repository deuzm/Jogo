//
//  CreateJogViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CreateJogViewController: UIViewController {
    
    //MARK: - properties
    
    @IBOutlet weak var distanceTextView: StyledTextField!
    @IBOutlet weak var timeTextField: StyledTextField!
    @IBOutlet weak var dateTextField: StyledTextField!
    @IBOutlet weak var navigationBar: BearNavigationBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var jogEdited = false
    var jog: Jog? = Jog()
    var jogs: [Jog] = []
    
    //MARK: - main view setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.filterButton?.isHidden = true
        navigationBar.menuButton?.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        
        if(jogEdited) {
            distanceTextView.text = String(jog!.distance)
            timeTextField.text = String(jog!.time)
            dateTextField.text = jog!.date
        }
        distanceTextView.delegate = self
        timeTextField.delegate = self
        dateTextField.delegate = self
        
    }
    
    //MARK: - actions
    
    @objc func menuButtonTapped() {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let distance = distanceTextView.text, !distance.isEmpty else {
            AlertHelper().showErrorAlert(withMessage: "Distance is empty", vc: self)
            return
        }
        guard let time = timeTextField.text, !time.isEmpty else {
            AlertHelper().showErrorAlert(withMessage: "Time is empty", vc: self)
            return
        }
        guard let date = dateTextField.text, !date.isEmpty else {
            AlertHelper().showErrorAlert(withMessage: "Date is empty", vc: self)
            return
        }
        guard let timeFloat = Float(time) else {
            return
        }
        guard let distanceFloat = Float(distance) else {
            return
        }
        
        if(self.jogEdited == true) {
            self.updateJog(distance: distanceFloat, time: timeFloat, date: date)
        }
        else {
            self.saveJog(distance: distanceFloat, time: timeFloat, date: date)
        }
    }
        
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let realm = try! Realm()
        AlamofireRequests().getAndSaveJogs() { (ok)
            in
            self.ok = ok
            if(ok) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "unwindSegue", sender: self)
                    self.activityIndicator.stopAnimating()
                }

            }
        }
    }
        
    //MARK: - save/update jog functions
    var ok = false
    
    func updateJog(distance: Float, time: Float, date: String) {
        print(date)
        ok = false
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
            AlamofireRequests().updateJog(distance: Int(distance), time: time, date: date, jog_id: Int(self.jog!.id!) ?? 0, user_id: self.jog!.user_id) {
                (ok) in
                    
                self.ok = ok
                if(!ok) {
                    AlertHelper().showErrorAlert(withMessage: "Could not update jog", vc: self)
                }
                else {
                    AlamofireRequests().getAndSaveJogs() {
                    (ok) in
                    self.ok = ok
                    if(self.ok) {
                        let realm = try! Realm()
                        self.jogs = Array(realm.objects(Jog.self)).sorted(by:
                                { $0.date.toDate()! < $1.date.toDate()! })
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "unwindSegue", sender: self)
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    
    
    func saveJog(distance: Float, time: Float, date: String) {
        self.jog!.distance = distance
        self.jog!.time = time
        self.jog!.date = date
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        AlamofireRequests().addJog(distance: distance, time: time, date: date) {
            (ok) in
            self.ok = ok
            if(!ok) {
                AlertHelper().showErrorAlert(withMessage: "Could not save jog", vc: self)
            }
            else {
                AlamofireRequests().getAndSaveJogs() {
                    (ok) in
                    self.ok = ok
                    if(self.ok) {
                        let realm = try! Realm()
                        self.jogs = Array(realm.objects(Jog.self)).sorted(by:
                                { $0.date.toDate()! < $1.date.toDate()! })
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "unwindSegue", sender: self)
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
//MARK: - segue handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? JogsViewController {
            destination.jogsTableVC.jogs = self.jogs
            print(self.jogs)
            destination.jogsTableVC.tableView.reloadData()
            
        }
    }
}
   
//MARK: - text field delegate extension
extension CreateJogViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }
        return DateTextFieldFormatter().checkDateTextField(textField: textField, range: range, string: string)
    }
    
}
