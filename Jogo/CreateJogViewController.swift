//
//  CreateJogViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import CoreData

class CreateJogViewController: UIViewController {
    
    @IBOutlet weak var distanceTextView: styledTextField!
    @IBOutlet weak var timeTextField: styledTextField!
    @IBOutlet weak var dateTextField: styledTextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distanceTextView.delegate = self
        timeTextField.delegate = self
        dateTextField.delegate = self
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let distance = distanceTextView.text, distance.isEmpty else {
            return
        }
        guard let time = timeTextField.text, time.isEmpty else {
            return
        }
        guard let date = dateTextField.text, date.isEmpty else {
            return
        }
        guard let timeFloat = Float(time) else {
            return
        }
        guard let distanceFloat = Float(distance) else {
            return
        }
        if(date.count == 9) {

            saveJog(distance: distanceFloat, time: timeFloat, date: date)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveJog(distance: Float, time: Float, date: String) {
      
        guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
        }

        let managedContext =
        appDelegate.persistentContainer.viewContext

        let entity =
        NSEntityDescription.entity(forEntityName: "Jog",
                                   in: managedContext)!

        let jog = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

        // 3
        jog.setValue(distance, forKeyPath: "distance")
        jog.setValue(time, forKey: "time")
        jog.setValue(date, forKey: "date")


        // 4
        do {
        try managedContext.save()
        Jogs.shared.jogs.append(jog)
        } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CreateJogViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }

        var numm = textField.text?.count
        
        var allowedCharacters: CharacterSet
        allowedCharacters = CharacterSet(charactersIn:"0123456789.")
        
        if textField.accessibilityIdentifier == "date" {
            var dd: String
            var mm: String
            var ddIsInBounds = true
            var mmIsInBounds = true
            //dots after 2 and 5-th chars
            if (textField.text?.count == 2) || (textField.text?.count == 5) {
                if !(string == "") {
                    if (textField.text?.count == 2) {
                        //checking that date is not > than 31
                        let str = textField.text
                        dd = String(str?.suffix(2) ?? "")
                        if(dd.first == "3") {
                            let num = Int(dd)!
                            if(num > 31) {
                                return false
                            }
                            else {
                                ddIsInBounds = true
                            }
                        }
                    } else {
                        //Checking that month is not > than 12
                        let str = textField.text!
                        dd = String(str.prefix(2))
                        mm = String(str.suffix(2))
                        if(mm.first == "1") {
                            let num = Int(mm)!
                            if(num > 12) {
                                return false
                            }
                            else {
                                mmIsInBounds = true
                            }
                        }
                    }
                    
                    textField.text = (textField.text)! + "."
                }
            }
            
            if !(string == "") {
            if(numm == 1) {
                if let num = Int(textField.text!) {
                    if(num > 3) {
                        return false
                    }
                }
            }
            if(numm == 2) {
                if let num = Int(String((textField.text?.last)!)) {
                    dd = textField.text!
                    if(dd.first == "3") {
                        if(num > 1) {
                            return false
                        }
                    }
                }
            }
            if(numm == 5) {
                //february check
                let num = (textField.text)!
                if(num.suffix(3) == "02.") {
                    dd = String(num.prefix(2))
                    let numDd = Int(dd)!
                    if(numDd > 29) {
                        textField.text! = "28.02."
                        return false
                    }
                }
                if let num = Int(String((textField.text?.last)!)) {
                    if(num > 1) {
                        return false
                    }
                }
            }
            }
            
            let rightFormat = !(textField.text!.count > 9 && (string.count) > range.length)

            allowedCharacters = CharacterSet(charactersIn:"0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            let isDigit = allowedCharacters.isSuperset(of: characterSet)

            return rightFormat && isDigit && ddIsInBounds && mmIsInBounds
            
        }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) &&
                replacementText.isValidDouble(maxDecimalPlaces: 2)
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
