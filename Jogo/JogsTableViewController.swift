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

    var jogs: [Jog] = []
    var createJogVC: CreateJogViewController!
    var tappedCell: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        AlamofireRequests().getAndSaveJogs()
        self.jogs = Array(realm.objects(Jog.self))
        print(jogs)
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
        let speed = distanceVal / timeVal
        
        dateLabel.text = jogs[indexPath.row].date
        distanceLabel.text = String(jogs[indexPath.row].distance)
        speedLabel.text = String(speed.rounded())
        timeLabel.text = String(jogs[indexPath.row].time)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tappedCell = indexPath
         performSegue(withIdentifier: "createJogSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? CreateJogViewController,
            segue.identifier == "createJogSegue" {
            let cell = tableView.cellForRow(at: tappedCell)
            let dateLabel = cell?.viewWithTag(3) as! UILabel
            let distanceLabel = cell?.viewWithTag(5) as! UILabel
            let timeLabel = cell?.viewWithTag(6) as! UILabel
            
//            vc.dateTextField.text = dateLabel.text
//            vc.distanceTextView.text = distanceLabel.text
//            vc.timeTextField.text = timeLabel.text
            
            vc.jog = jogs[tappedCell.row]
            vc.jogEdited = true
            self.createJogVC = vc
        }

    }

}
