//
//  JogsViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class JogsViewController: UIViewController {

    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var createJogButton: letMeInButton!
    @IBOutlet weak var nothingIsThereLabel: UILabel!
    @IBOutlet weak var sadFaceImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
    }

}
