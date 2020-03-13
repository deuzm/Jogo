//
//  StyledTextView.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/12/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

@IBDesignable class StyledTextView: UITextView {

    @IBInspectable var lineSpacing: CGFloat = 24
    @IBInspectable var textFont = UIFont.textStyle5
    
    override func draw(_ rect: CGRect) {
        
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
        
        font = textFont
    }

}
