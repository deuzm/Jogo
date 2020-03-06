//
//  navigationBarProtocol.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

protocol NavigationBarProtocol {
    var logoImage: UIImage { get set }
    var menuButtonImage: UIImage? { get set }
    var logoImageColor: UIColor { get set }
    var fillColor: UIColor { get set }
}
