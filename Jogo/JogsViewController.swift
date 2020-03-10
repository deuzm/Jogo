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

    @IBOutlet weak var animatedTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var createJogButton: letMeInButton!
    @IBOutlet weak var nothingIsThereLabel: UILabel!
    @IBOutlet weak var sadFaceImageView: UIImageView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var filterBar: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    var filterIsInactive = true
    
    var filterButton: UIButton = UIButton()
    
    var jogs: [Jog] = []
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        self.jogs = Array(realm.objects(Jog.self))
        
        setUpViews()
        
        DispatchQueue.main.async {
            AlamofireRequests().getAndSaveJogs()
        }
    
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        
        navigationBar = navigationBar as! BearNavigationBar
        
        filterButton = navigationBar.viewWithTag(2) as! UIButton
        
        filterButton.addTarget(self, action: #selector(self.filterButtonTapped), for: .touchUpInside)
        
        //nothing is there look
        if jogs.isEmpty {
            filterButton.isHidden = true
            addButton.isHidden = true
            tableViewContainer.isHidden = true
            
            createJogButton.isHidden = false
            nothingIsThereLabel.isHidden = false
            sadFaceImageView.isHidden = false
        }
        //cells look
        else {
            filterButton.isHidden = false
            addButton.isHidden = false
            tableViewContainer.isHidden = false
            
            
            createJogButton.isHidden = true
            nothingIsThereLabel.isHidden = true
            sadFaceImageView.isHidden = true
        }
        
        view.bringSubviewToFront(navigationBar)
        view.bringSubviewToFront(view.viewWithTag(7)!)
        
    }
    
    @objc func filterButtonTapped() {
        if filterIsInactive {
            
            filterButton.setImage(UIImage(named: "filterActive"), for: .normal)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3) {
                self.animatedTopConstraint.constant  = 17
                self.view.layoutIfNeeded()
            }
        }
        else {
            filterButton.setImage(UIImage(named: "filter"), for: .normal)
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3) {
                self.animatedTopConstraint.constant  = 77
                self.view.layoutIfNeeded()
            }
        }
        filterIsInactive = !filterIsInactive
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "createJogSegue", sender: self)
    }
    

}
