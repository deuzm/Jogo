//
//  JogsViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import RealmSwift

class JogsViewController: UIViewController {

    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var createJogButton: letMeInButton!
    @IBOutlet weak var nothingIsThereLabel: UILabel!
    @IBOutlet weak var sadFaceImageView: UIImageView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var filterBar: UIView!
    
    var filterIsInactive = true
    
    var filterButton: UIButton = UIButton()
    
    var jogs: [Jog] = []
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        AlamofireRequests().getAndSaveJogs()
        jogs = Array(realm.objects(Jog.self))
        
        //nothing is there look
        if jogs.isEmpty {
            createJogButton.isHidden = false
            nothingIsThereLabel.isHidden = false
            sadFaceImageView.isHidden = false
            tableViewContainer.isHidden = true
        }
        //cells look
        else {
            createJogButton.isHidden = true
            nothingIsThereLabel.isHidden = true
            sadFaceImageView.isHidden = true
            tableViewContainer.isHidden = false
        }
        
        navigationBar = navigationBar as! BearNavigationBar
        
        filterButton = navigationBar.viewWithTag(2) as! UIButton
        filterButton.addTarget(self, action: #selector(self.filterButtonTapped), for: .touchUpInside)
        view.bringSubviewToFront(navigationBar)
        view.bringSubviewToFront(view.viewWithTag(7)!)
        
        AlamofireRequests().getAndSaveJogs()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
    }
    @IBOutlet weak var topMovingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var animationViewHeightConstraint: NSLayoutConstraint!
    
    @objc func filterButtonTapped() {
        if filterIsInactive {
            
            filterButton.setImage(UIImage(named: "filterActive"), for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                self.animationViewHeightConstraint.constant  = 84
                self.view.layoutIfNeeded()
            }
        }
        else {
            filterButton.setImage(UIImage(named: "filter"), for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                
                self.animationViewHeightConstraint.constant  = 24
                self.view.layoutIfNeeded()
            }
        }
        filterIsInactive = !filterIsInactive
        print("lol")
    }

}
