//
//  ViewController.swift
//  InstaClone
//
//  Created by Yavuz Ulgar on 30.01.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, MakeAlert {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.alert(titleInput: "Hata", hataInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            let alert = makeAlert(titleInput: "Alert", hataInput: "Email and password fields cannot be empty")
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.alert(titleInput: "Error!", hataInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            let alert = makeAlert(titleInput: "Error", hataInput: "Email/Password")
            self.present(alert, animated: true)
        }
        
    }
    
    func alert(titleInput : String, hataInput : String) {
        let alert = UIAlertController(title: titleInput, message: hataInput, preferredStyle: UIAlertController.Style.alert)
        let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertButton)
        self.present(alert, animated: true)
        
    }
}

