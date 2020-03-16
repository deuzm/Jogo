//
//  JogsTableViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import RealmSwift

class JogsTableViewController: UITableViewController {
//   MARK: - properties
    var jogs: [Jog] = []
    var createJogVC: CreateJogViewController!
    var tappedCell: IndexPath!
    var ok = false
    
//   MARK: - main view setup
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jogs.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dateLabel = cell.viewWithTag(3) as! UILabel
        let speedLabel = cell.viewWithTag(4) as! UILabel
        let distanceLabel = cell.viewWithTag(5) as! UILabel
        let timeLabel = cell.viewWithTag(6) as! UILabel
        
        let distanceVal = jogs[indexPath.row].distance
        let timeVal = jogs[indexPath.row].time
        let speed = (distanceVal) / (timeVal != 0 ? timeVal : MAXFLOAT)
        
        dateLabel.text = jogs[indexPath.row].date
        distanceLabel.text = String(jogs[indexPath.row].distance)
        speedLabel.text = String(speed.rounded(toPlaces: 3))
        timeLabel.text = String(jogs[indexPath.row].time)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tappedCell = indexPath
         performSegue(withIdentifier: "createJogSegue", sender: self)
    }
    
    //MARK: - segue handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? CreateJogViewController,
            segue.identifier == "createJogSegue" {
        
            vc.jog = jogs[tappedCell.row]
            vc.jogEdited = true
            
            self.createJogVC = vc
        }
    }
}
