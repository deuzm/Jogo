//
//  JogsViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/6/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

protocol isAbleToReceiveData {
  func pass(data: String)  //data: string is an example parameter
}

class JogsViewController: UIViewController {

    @IBOutlet weak var dateFromTextField: styledTextField!
    @IBOutlet weak var dateToTextField: styledTextField!
    
    @IBOutlet weak var animatedTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var createJogButton: letMeInButton!
    @IBOutlet weak var nothingIsThereLabel: UILabel!
    @IBOutlet weak var sadFaceImageView: UIImageView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var filterBar: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    var jogsTableVC: JogsTableViewController!
    
    
    var filterIsInactive = true
    
    var filterButton: UIButton = UIButton()
    
    var jogs: [Jog] = [] 
    var filtered: [Jog] = []
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
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
        
        self.animatedTopConstraint.constant  = 17
        view.bringSubviewToFront(navigationBar)
        view.bringSubviewToFront(view.viewWithTag(7)!)
        
    }
    
    
    
    @IBAction func dateFromEditingDidFinish(_ sender: Any) {
        guard let dateFrom = dateFromTextField.text, !dateFrom.isEmpty else {
            filtered = jogs
            return
        }
        
        if let dateTo = dateToTextField.text, dateTo.isEmpty {
            filtered = jogs
            setDateFromTo(dateFrom, to: false)
        }
        setDateFromTo(dateFrom, to: false)
    }
    
    @IBAction func dateToEditingDidFinish(_ sender: Any) {
        guard let dateTo = dateToTextField.text, !dateTo.isEmpty else {
            filtered = jogs
            return
        }
        if let dateFrom = dateFromTextField.text, dateFrom.isEmpty {
            filtered = jogs
            setDateFromTo(dateTo, to: true)
        }
        setDateFromTo(dateTo, to: true)
    }
    
    func setDateFromTo(_ date: String, to: Bool) {
        //Implementation for date in form of an int
//        if let dateVar = Int(date) {
//            filtered = filtered.filter {
//                if let dateInt = Int($0.date) {
//                    if(to) {
//                        return dateInt < dateVar
//                    }
//                    else {
//                        return dateInt > dateVar
//                    }
//
//                }
//                return false
//            }
//        } else
        if let datevar = date.toDate() {
            filtered = filtered.filter {
                if let dateInt = ($0.date).toDate() {
                    if(!to) {
                        return dateInt.compare(datevar) == ComparisonResult.orderedDescending ||
                                dateInt.compare(datevar) == ComparisonResult.orderedSame
                    }
                    else {
                        return dateInt.compare(datevar) == ComparisonResult.orderedAscending ||
                            dateInt.compare(datevar) == ComparisonResult.orderedSame
                    }
                     
                }
                return false
            }
        }
        self.jogsTableVC.jogs = filtered
        self.jogsTableVC.tableView.reloadData()
    }
    
    @objc func filterButtonTapped() {
        dateFromTextField.text = ""
        dateToTextField.text = ""
        if filterIsInactive {
            self.filtered = jogs
            self.jogsTableVC.jogs = jogs
            self.jogsTableVC.tableView.reloadData()
            filterButton.setImage(UIImage(named: "filter"), for: .normal)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3) {
                self.animatedTopConstraint.constant  = 17
                self.view.layoutIfNeeded()
            }
        }
        else {
            filterButton.setImage(UIImage(named: "filterActive"), for: .normal)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? JogsTableViewController,
            segue.identifier == "jogsTableViewSegue" {
            
            vc.jogs = jogs
            self.jogsTableVC = vc
        }

    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let source = segue.source as? CreateJogViewController {
            
            AlamofireRequests().getAndSaveJogs()
            
            let realm = try! Realm()
            self.jogs = Array(realm.objects(Jog.self))
            self.filtered = self.jogs
            self.jogsTableVC.jogs = self.jogs
            
            self.jogsTableVC.tableView.reloadData()
        }
    }
    

    
}

extension String {
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter.date(from: self)
    }
}

extension JogsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }
        return DateFormatter().checkDateTextField(textField: textField, range: range, string: string)
    }
    
}
