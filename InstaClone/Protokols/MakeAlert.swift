//
//  MakeAlert.swift
//  InstaClone
//
//  Created by Yavuz Ulgar on 6.04.2023.
//

import Foundation
import UIKit

protocol MakeAlert {
    func makeAlert(titleInput : String, hataInput : String) -> UIAlertController
}

extension MakeAlert {
    func makeAlert(titleInput : String, hataInput : String) -> UIAlertController {
        let alert = UIAlertController(title: titleInput, message: hataInput, preferredStyle: UIAlertController.Style.alert)
        let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertButton)
        return alert
    }
}
