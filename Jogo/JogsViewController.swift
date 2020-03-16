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
    
    //MARK: - outlets

    @IBOutlet weak var dateFromTextField: StyledTextField!
    @IBOutlet weak var dateToTextField: StyledTextField!
    
    @IBOutlet weak var animatedTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var createJogButton: LetMeInButton!
    @IBOutlet weak var nothingIsThereLabel: UILabel!
    @IBOutlet weak var sadFaceImageView: UIImageView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var filterBar: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: - properties
    
    var jogsTableVC: JogsTableViewController!
    
    var filterIsInactive = false
    
    var filterButton: UIButton = UIButton()
    var menuButton: UIButton = UIButton()
    
    var jogs: [Jog] = [] 
    var filtered: [Jog] = []
    var ok = false
    
    //MARK: - main view setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateToTextField.delegate = self
        dateFromTextField.delegate = self
        setUpViews()
    }
    
    func setUpViews() {
        
        view.bringSubviewToFront(navigationBar)
        
        navigationBar = navigationBar as! BearNavigationBar
        
        filterButton = navigationBar.viewWithTag(2) as! UIButton
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        menuButton = navigationBar.viewWithTag(3) as! UIButton
        
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        
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
        
    }
    
    
    //MARK: - actions
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

    @objc func menuButtonTapped() {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
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
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let source = segue.source as? CreateJogViewController {
            
            let realm = try! Realm()
            self.jogs = Array(realm.objects(Jog.self))
            print(self.jogs.first)
            self.jogs = self.jogs.sorted(by: {$0.date.toDate()! < $1.date.toDate()!})
            self.filtered = self.jogs
            self.jogsTableVC.jogs = self.jogs
            
            self.jogsTableVC.tableView.reloadData()
        }
    }
    
    func setDateFromTo(_ date: String, to: Bool) {
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
    
   
    // MARK: - segue handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? JogsTableViewController,
            segue.identifier == "jogsTableViewSegue" {
            vc.jogs = jogs
            self.jogsTableVC = vc
        }
    }
}

//MARK: - text field delegate extension
extension JogsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        
        return DateTextFieldFormatter().checkDateTextField(textField: textField, range: range, string: string)
    }
    
}
