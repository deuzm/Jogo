//
//  navigationBarModel.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

public struct BaseNavigationBarModel: NavigationBarProtocol {
    var logoImage: UIImage
    
    var menuButtonImage: UIImage?
    
    var filterButtonImage: UIImage
    
    var logoImageColor: UIColor
    
    var fillColor: UIColor
    
    
    init() {
        logoImage = UIImage(named: "logo")!
        menuButtonImage = UIImage(named: "menu")!
        filterButtonImage = UIImage(named: "menu")!
        fillColor = UIColor.appleGreen
        logoImageColor = UIColor.white
    }
}

public struct HomePageNavigationBarModel: NavigationBarProtocol {
    var logoImage: UIImage
    
    var menuButtonImage: UIImage?
    
    var filterButtonImage: UIImage
    
    var logoImageColor: UIColor
    
    var fillColor: UIColor
    
    
    init() {
        logoImage = UIImage(named: "logoGreen")!
        filterButtonImage = UIImage(named: "menu")!
        fillColor = .whiteThree
        logoImageColor = UIColor.green
    }
}
