//
//  SegueFromLeft.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/12/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit


class SegueFromLeft: UIStoryboardSegue {
    
    override func perform() {

        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)

        UIView.animate(withDuration: 0.25,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
            },
            completion: { finished in
                src.present(dst, animated: false, completion: nil)
            }
        )
        }
    }

