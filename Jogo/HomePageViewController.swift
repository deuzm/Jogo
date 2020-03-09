//
//  HomePageViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    //properties
    var navigationBar: UINavigationBar = BearNavigationBar(navigationBarStyle: HomeNavigationBarModel())

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        view.addSubview(navigationBar)
        AlamofireRequests().getAndSaveJogs()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
