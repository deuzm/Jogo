//
//  ContactUsViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet weak var navigationBar: BearNavigationBar!
    
    //MARK: - main view setup
    override func viewDidLoad() {
        super.viewDidLoad()

        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped(_:)))
        edgePan.edges = .left

        view.addGestureRecognizer(edgePan)
        
        navigationBar.filterButton?.isHidden = true
        navigationBar.menuButton?.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - actions
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            performSegue(withIdentifier: "feedBackSegue", sender: self)
        }
    }
    
    @objc func menuButtonTapped() {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }
}
