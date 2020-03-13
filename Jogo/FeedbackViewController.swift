//
//  FeedbackViewController.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/12/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    // MARK: - properties
    @IBOutlet weak var textView: StyledTextView!
    @IBOutlet weak var chooseTopicButton: UIButton!
    @IBOutlet weak var navigationBar: BearNavigationBar!
    
    var ok = false
    var pickerData: [String] = [String]()
    
    //MARK: - view did load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerData = ["1", "2", "3", "5", "8"]
        
        navigationBar.filterButton?.isHidden = true
        navigationBar.menuButton?.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - actions
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let text = textView.text, !text.isEmpty else {
            AlertHelper().showErrorAlert(withMessage: "Text is empty", vc: self)
            return
        }
        guard let topic = chooseTopicButton.titleLabel?.text, !topic.isEmpty else {
            return
        }
        guard let topicNumeric = Int(topic) else {
            AlertHelper().showErrorAlert(withMessage: "Could not parse topic", vc: self)
            return
        }
        AlamofireRequests().sendFeedback(topic_id: topic, text: text) {
            (ok) in
            self.ok = ok
            if(!ok) {
                AlertHelper().showErrorAlert(withMessage: "Could not send Feedback", vc: self)
            }
            else {
                self.performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
            }
        }
        
    }
    
    @IBAction func chooseTopicButtonTapped(_ sender: Any) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 100)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        
        let editRadiusAlert = UIAlertController(title: "Choose topic", message: "", preferredStyle: .alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            a in
            self.chooseTopicButton.setTitle(self.pickerData[pickerView.selectedRow(inComponent: 0)], for: .normal)
            return
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
    
    @objc func menuButtonTapped() {
           performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
       }
    
    // MARK: - picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
