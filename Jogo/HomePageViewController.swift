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
    
    //MARK: - properties
    var navigationBar: UINavigationBar = BearNavigationBar(navigationBarStyle: HomeNavigationBarModel())
    var jogs: [Jog] = []
    var weeks: [Int: [Week?]] = [:]
    var representitiveWeeks: [Week] = []
    
    //MARK: - main view setup
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        view.addSubview(navigationBar)
        activityIndicator.isHidden = true
        
    }
    
    //MARK: - actions
    
    @IBAction func statsButtonTapped(_ sender: Any) {
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            self.jogs = Array(realm.objects(Jog.self))
            self.setWeeks()
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "statsSegue", sender: self)
            }
        }
        
    }
    
    @IBAction func jogsButtonTapped(_ sender: Any) {
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            self.jogs = Array(realm.objects(Jog.self))
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "jogsSegue", sender: self)
            }
        }
    }
    //MARK: - segue handling
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? JogsViewController {
            let realm = try! Realm()
            self.jogs = Array(realm.objects(Jog.self))
            destination.jogs = jogs
            destination.filtered = jogs

        }
        if let destination = segue.destination as? StatsTableViewController {
            destination.jogs = self.jogs
            destination.weeks = self.weeks
            destination.representitiveWeeks = self.representitiveWeeks
        }
    }
    //MARK: - setting weeks for stats
    func setWeeks() {
        jogs = jogs.sorted(by: { $0.date.toDate()! < $1.date.toDate()! })
        
        var weekCounter = 0
        let calendar = Calendar.current
        var previousYear = 0
        var previousWeek: Int = 0
        
        for jog in jogs {
            let jogDate = jog.date.toDate()!
            let weekOfYear = calendar.component(.weekOfYear, from: jogDate)
            let year = calendar.component(.year, from: jogDate)
            
            if(previousYear != year) {
                weekCounter = 0
                weeks[year] = []
            }
            
            if previousYear == year {
                previousYear = year
                if previousWeek == weekOfYear {
                    
                    let speed = jog.distance / (jog.time != 0 ?
                    jog.time : MAXFLOAT)
                    
                    weeks[year]?[weekCounter - 1]?.distance += jog.distance
                    weeks[year]?[weekCounter - 1]?.time += jog.time
                    weeks[year]?[weekCounter - 1]?.speed += speed.rounded(toPlaces: 3)
                    
                    continue
                }
                else
                    
                {
                    weeks[year]?.append(Week())
                    
                    let speed = jog.distance / (jog.time != 0 ? jog.time : MAXFLOAT)
                    
                    weeks[year]?.last!!.id = String(weekCounter + 1)
                    weeks[year]?.last!!.date = jog.date
                    weeks[year]?.last!!.distance = jog.distance
                    weeks[year]?.last!!.time = jog.time
                    weeks[year]?.last!!.speed = speed.rounded(toPlaces: 3)
                    
                    previousWeek = weekOfYear
                    weekCounter += 1
                    continue
                    
                }
            }
            else {

                previousYear = year
                weeks[year] = []
                weeks[year]?.append(Week())
                
                let speed = (jog.distance / (jog.time != 0 ? jog.time : MAXFLOAT))
                
                weeks[year]?[0]?.id = "1"
                weeks[year]?[0]?.date = jog.date
                weeks[year]?[0]?.distance = jog.distance
                weeks[year]?[0]?.time = jog.time
                weeks[year]?[0]?.speed = speed.rounded(toPlaces: 3)
                
                previousWeek = weekOfYear
                weekCounter += 1
                
                continue
            }
        }
        
        for (_, weeksArray) in weeks {
            for week in weeksArray {
                if week != nil {
                    representitiveWeeks.append(week!)
                }
            }
        }
        representitiveWeeks.sort(by: { $0.date.toDate()! < $1.date.toDate()! })
        print(representitiveWeeks)
    }
}


