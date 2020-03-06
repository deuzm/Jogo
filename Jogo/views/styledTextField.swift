//
//  styledTextField.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

@IBDesignable class styledTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 7
    @IBInspectable var borderColor = UIColor.warmGrey
    @IBInspectable var bgColor = UIColor.whiteThree
    @IBInspectable var borderWidth = CGFloat(1)
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = bgColor.cgColor
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

}
