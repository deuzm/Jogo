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
    
    
    lazy var barImage: UIImageView = {
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
        container.addSubview(barImage)
        backgroundView.addSubview(container)
        addSubview(backgroundView)
        
        //Adding menu button if there is an image
        if let menuImage = navBarModel.menuButtonImage {
            if let menu = menuButton {
                container.addSubview(menu)
                if navBarModel is JogsNavigationBarModel {
                    jogsConstraints()
                }
                else {
                    setUpConstraintsForLogIn()
                }
            }
        } else {
            menuButton = nil
            setUpConstraintsForHomePage()
        }
        let backgroundConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: .alignAllCenterY, metrics: nil, views: ["v0": backgroundView])
        let containerConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]-20-|", options: .alignAllCenterY, metrics: nil, views: ["v0": container])
        addConstraints(containerConstraint)
        addConstraints(backgroundConstraint)
    }
    
    func setUpConstraintsForHomePage() {
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-25-[image]|",
            options: NSLayoutConstraint.FormatOptions(),
            metrics: nil,
            views: ["image": barImage])
        addConstraints(horizontalConstraints)
    }
    
    func setUpConstraintsForLogIn() {
        let views = ["image": barImage,
                     "menu": menuButton]
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-7-[menu]-6-|",
            options: NSLayoutConstraint.FormatOptions(),
            metrics: nil,
            views: views as [String : Any])
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-25-[image]-199-[menu]-25-|",
            options: NSLayoutConstraint.FormatOptions(),
            metrics: nil,
            views: views as [String : Any])
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraints)
    }
    
    func setFilterButton() {
        //adding filter button on containter view
        if let jogsModel = navBarModel as? JogsNavigationBarModel {
             container.addSubview(self.filterButton!)
        }
    }
    
    func jogsConstraints() {
        //setting
        let views = ["image": barImage,
                     "filter": filterButton,
                     "menu": menuButton]
        let menuVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-7-[menu]-6-|",
            metrics: nil,
            views: views as [String : Any])
        let filterVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-6-[filter]-5-|",
            metrics: nil,
            views: views as [String : Any])
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-25-[image]-128-[filter]-[menu]-25-|",
            metrics: nil,
            views: views as [String : Any])
        container.addConstraints(filterVerticalConstraints)
        container.addConstraints(horizontalConstraints)
        container.addConstraints(menuVerticalConstraints)
    }
    
    
}
