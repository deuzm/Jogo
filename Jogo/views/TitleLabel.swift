//
//  TitleLabel.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/12/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

@IBDesignable class TitleLabel: UILabel {
    @IBInspectable var textFont = UIFont.textStyle
    
    override func draw(_ rect: CGRect) {
        font = textFont
    }
    

}
