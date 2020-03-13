//
//  StatsTableViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/12/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {
    //MARK: - properties and outlets
    var jogs: [Jog] = [Jog]()
    var weeks: [Int: [Week?]] = [:]
    var representitiveWeeks: [Week] = []

    @IBOutlet weak var navigationBar: BearNavigationBar!
    
    //MARK: - main view setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.filterButton?.isHidden = true
        navigationBar.menuButton?.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - actions
    @objc func menuButtonTapped() {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representitiveWeeks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath)
        let weekLabel = cell.viewWithTag(1) as? UILabel
        let dateLabel = cell.viewWithTag(2) as! UILabel
        let speedLabel = cell.viewWithTag(3) as! UILabel
        let distanceLabel = cell.viewWithTag(4) as! UILabel
        let timeLabel = cell.viewWithTag(5) as! UILabel
        
        let date = representitiveWeeks[indexPath.row].date.toDate()!
        let dateString = "(" + date.startOfWeek!.toString + ") / (" + date.endOfWeek!.toString + ")"
        
        dateLabel.text = dateString
            
        weekLabel?.text = representitiveWeeks[indexPath.row].id
        distanceLabel.text = String(representitiveWeeks[indexPath.row].distance)
        timeLabel.text = String(representitiveWeeks[indexPath.row].time)
        speedLabel.text = String(representitiveWeeks[indexPath.row].speed)
    
        return cell
    }
}
