//
//  letMeInButton.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

@IBDesignable class LetMeInButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30
    @IBInspectable var borderWidth: CGFloat = 3
    @IBInspectable var titleColor = UIColor.babyPurple
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        setTitleColor(titleColor, for: .normal)
        layer.borderColor = titleColor.cgColor
    }

}
