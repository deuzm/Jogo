//
//  DateFormatter.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/9/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class DateTextFieldFormatter {
    
//MARK: - check date textField function
    func checkDateTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        let charCount = textField.text?.count
        
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
                if(charCount == 1) {
                    if let num = Int(textField.text!) {
                        if(num > 3) {
                            return false
                        }
                    }
                }
                //checking that if the date begins with 3, the second digit is not greater than 1
                if(charCount == 2) {
                    if let num = Int(String((textField.text?.last)!)) {
                        dd = textField.text!
                        if(dd.first == "3") {
                            if(num > 1) {
                                return false
                            }
                        }
                    }
                }
                //checking that first char of month is not greater than 1
                if (charCount == 4) {
                    if let num = Int(String((textField.text?.last)!)) {
                        if num > 1 {
                            return false
                        }
                    }
                }
                if(charCount == 5) {
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

            return isDigit && ddIsInBounds && mmIsInBounds && rightFormat 
            
        }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) &&
                replacementText.isValidDouble(maxDecimalPlaces: 5)
    }
}

