//
//  InfoViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var navigationBar: BearNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.filterButton?.isHidden = true
        navigationBar.menuButton?.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    @objc func menuButtonTapped() {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }

}
