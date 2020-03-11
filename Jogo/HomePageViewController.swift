//
//  HomePageViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import RealmSwift

class HomePageViewController: UIViewController {
    
    //properties
    var navigationBar: UINavigationBar = BearNavigationBar(navigationBarStyle: HomeNavigationBarModel())

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    var jogs: [Jog] = []
    
    func setUpViews() {
        view.addSubview(navigationBar)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? JogsViewController {
            let realm = try! Realm()
            self.jogs = Array(realm.objects(Jog.self))
            destination.jogs = jogs
            destination.filtered = jogs
        }
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
