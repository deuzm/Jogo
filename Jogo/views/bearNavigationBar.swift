//
//  bearNavigationBar.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/5/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class BearNavigationBar: UINavigationBar {

    //properties
    var safeArea = UILayoutGuide()
    var navBarModel: NavigationBarProtocol = BaseNavigationBarModel()
    
    @IBInspectable var fillColor: UIColor = UIColor.appleGreen
    var logoImage: UIImage = UIImage(named: "logo")!
    var menuImage: UIImage = UIImage(named: "menu")!
    
    
    lazy var backgroundView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let view = UIView(frame: rect)
        view.clipsToBounds = true
        view.backgroundColor = fillColor
        return view
    }()
    
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = logoImage
        imageView.frame = CGRect(x: 0, y: 0, width: 98, height: 37)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var menuButton: UIButton? = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 24))
        button.setBackgroundImage(menuImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var filterButton: UIButton? = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        button.translatesAutoresizingMaskIntoConstraints = false
        if let jogsModel = self.navBarModel as? JogsNavigationBarModel {
            button.setImage(jogsModel.filterImage, for: .normal)
            button.setImage(jogsModel.filterActiveImage, for: .reserved)
        }
        return button
    }()
    
    
    lazy var container: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 37))
//           view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //initializers
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(77)))
        
        safeArea = self.layoutMarginsGuide
        setUpViews()
    }
    
    init(navigationBarStyle: NavigationBarProtocol) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(77)))
        navBarModel = navigationBarStyle
        safeArea = self.layoutMarginsGuide
        setUpViews()
        
    }
    
//Jogs navigation bar initializer
    required init?(coder: NSCoder) {
        navBarModel = JogsNavigationBarModel()
        super.init(coder: coder)
        safeArea = self.layoutMarginsGuide
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(77))
        setUpViews()
    }
    
    func setUpViews() {
        
        self.setValue(true, forKey: "hidesShadow")
        logoImage = navBarModel.logoImage
        fillColor = navBarModel.fillColor
        setFilterButton()
        container.addSubview(logoImageView)
        backgroundView.addSubview(container)
        addSubview(backgroundView)
        
        setBackgroundViewsConstraints()
        
        //Adding menu button if there is an image in a model
        
        if let menuImage = navBarModel.menuButtonImage {
            if let menu = menuButton {
                container.addSubview(menu)
                if navBarModel is JogsNavigationBarModel {
                    setMenuButtonConstraints()
                    setFilterButtonConstraints()
                }
                else {
                    setMenuButtonConstraints()
                }
            }
        } else {
            menuButton = nil
        }
        
    }
    
    func setBackgroundViewsConstraints() {
        let constraints = [
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: frame.width),
            backgroundView.heightAnchor.constraint(equalTo: widthAnchor),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 98),
            logoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setMenuButtonConstraints() {
        let constraints = [
            
            menuButton!.widthAnchor.constraint(equalToConstant: 28),
            menuButton!.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuButton!.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -25)
//            menuButton?.widthAnchor.constraint(equalToConstant: 28)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setFilterButtonConstraints() {
        let constraints = [

            filterButton!.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterButton!.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -98),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setFilterButton() {
        //adding filter button on containter view
        if let jogsModel = navBarModel as? JogsNavigationBarModel {
             container.addSubview(self.filterButton!)
        }
    }
}
