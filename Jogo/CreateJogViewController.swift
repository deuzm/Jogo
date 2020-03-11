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
    
    @IBOutlet weak var distanceTextView: styledTextField!
    @IBOutlet weak var timeTextField: styledTextField!
    @IBOutlet weak var dateTextField: styledTextField!
    
    var jogEdited = false
    var jog: Jog? = Jog()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(jogEdited) {
            distanceTextView.text = String(jog!.distance)
            timeTextField.text = String(jog!.time)
            dateTextField.text = jog!.date
        }
        distanceTextView.delegate = self
        timeTextField.delegate = self
        dateTextField.delegate = self
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    guard let distance = distanceTextView.text, !distance.isEmpty else {
                return
            }
            guard let time = timeTextField.text, !time.isEmpty else {
                return
            }
            guard let date = dateTextField.text, !date.isEmpty else {
                return
            }
            guard let timeFloat = Float(time) else {
                return
            }
            guard let distanceFloat = Float(distance) else {
                return
            }
            if(jogEdited == true) {
                self.updateJog(distance: distanceFloat, time: timeFloat, date: date)
                performSegue(withIdentifier: "unwindSegue", sender: self)
            }
            else {
                self.saveJog(distance: distanceFloat, time: timeFloat, date: date)
                performSegue(withIdentifier: "unwindSegue", sender: self)
            }
    //        if(date.count == 10) {

    //            saveJog(distance: distanceFloat, time: timeFloat, date: date)
    //        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    

    var ok = true
    func updateJog(distance: Float, time: Float, date: String) {
        print(date)
        AlamofireRequests().updateJog(distance: Int(distance), time: time, date: date, jog_id: Int(jog!.id!) ?? 0, user_id: jog!.user_id)
    }
    
    func saveJog(distance: Float, time: Float, date: String) {
        jog!.distance = distance
        jog!.time = time
        jog!.date = date
        AlamofireRequests().addJog(distance: distance, time: time, date: date) { (ok) in
            self.ok = ok
            if(ok)
            {
                print("molodeccc")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? JogsViewController {
            
            AlamofireRequests().getAndSaveJogs()
            let realm = try! Realm()
            destination.jogsTableVC.jogs = Array(realm.objects(Jog.self))
            destination.jogsTableVC.tableView.reloadData()
        }
    }
    
}


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
        return DateFormatter().checkDateTextField(textField: textField, range: range, string: string)
    }
    
}

extension String {
  func isValidDouble(maxDecimalPlaces: Int) -> Bool {
    let formatter = NumberFormatter()
    formatter.allowsFloats = true
    let decimalSeparator = formatter.decimalSeparator ?? "."
    
    if formatter.number(from: self) != nil {
      let split = self.components(separatedBy: decimalSeparator)

      
      let digits = split.count == 2 ? split.last ?? "" : ""

        
      return digits.count <= maxDecimalPlaces
    }

    return false
  }
}
