//
//  RoundedRectangle.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

@IBDesignable class RoundedRectangle: UIView {

    @IBInspectable var cornerRadius: CGFloat = 29
    @IBInspectable var bgColor = UIColor.appleGreen
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = bgColor.cgColor
    }

}
