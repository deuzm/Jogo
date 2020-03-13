//
//  FloatExtensions.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/13/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation

//MARK: - float rounding extension
extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
