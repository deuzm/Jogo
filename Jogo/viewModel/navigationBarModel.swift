//
//  navigationBarModel.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

public class BaseNavigationBarModel: NavigationBarProtocol {
    var logoImage: UIImage
    
    var menuButtonImage: UIImage?
    
    var logoImageColor: UIColor
    
    var fillColor: UIColor
    
    
    init() {
        logoImage = UIImage(named: "logo")!
        menuButtonImage = UIImage(named: "menu")!
        fillColor = UIColor.appleGreen
        logoImageColor = UIColor.white
    }
}

public struct HomeNavigationBarModel: NavigationBarProtocol {
    var logoImage: UIImage
    
    var menuButtonImage: UIImage?
    
    var logoImageColor: UIColor
    
    var fillColor: UIColor
    
    
    init() {
        logoImage = UIImage(named: "logoGreen")!
        fillColor = .whiteThree
        logoImageColor = UIColor.green
    }
}

public class JogsNavigationBarModel: BaseNavigationBarModel {
    var filterImage: UIImage
    var filterActiveImage: UIImage
    
    override init() {
        
        filterImage = UIImage(named: "filter")!
        filterActiveImage = UIImage(named: "filterActive")!
        
        super.init()
    }
    
}
