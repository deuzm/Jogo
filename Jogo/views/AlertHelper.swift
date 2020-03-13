//
//  AlertHelper.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/12/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    func showErrorAlert(withMessage: String, vc: UIViewController) {
        let alertController = UIAlertController(title: "Try again", message:
            withMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        vc.present(alertController, animated: true, completion: nil)
    }
}
