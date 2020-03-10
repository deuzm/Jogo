//
//  CreateJogViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
//import CoreData
//import RealmSwift

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
        if(date.count == 10) {

            saveJog(distance: distanceFloat, time: timeFloat, date: date)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    var ok = true
    func saveJog(distance: Float, time: Float, date: String) {
        AlamofireRequests().addJog(distance: distance, time: time, date: date) { (ok) in
            self.ok = ok
            if(ok)
            {
                print("molodeccc")
            }
        }
    }
//    Core data TODO
//    func saveJog(distance: Float, time: Float, date: String) {
//        guard let appDelegate =
//        UIApplication.shared.delegate as? AppDelegate else {
//        return
//        }
//        let managedContext =
//            appDelegate.persistentContainer.viewContext
//
//        managedContext.perform {
//
//            let entity =
//            NSEntityDescription.entity(forEntityName: "Jog",
//                                       in: managedContext)!
//
//            let jog = NSManagedObject(entity: entity,
//                                       insertInto: managedContext)
//
//            // 3
//            jog.setValue(distance, forKeyPath: "distance")
//            jog.setValue(time, forKey: "time")
//            jog.setValue(date, forKey: "date")
//
//
//            // 4
//            do {
//            try managedContext.save()
//            Jogs.shared.jogs.append(jog)
//            } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//            }
//        }
//    }
    
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
