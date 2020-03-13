//
//  StringExtensions.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/13/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation

//MARK: - string is valid double extension
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

//MARK: - string to date extension
extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.date(from: self)
    }
}
