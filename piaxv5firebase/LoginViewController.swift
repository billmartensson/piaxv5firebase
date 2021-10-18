//
//  LoginViewController.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-10-18.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerUser(_ sender: Any) {
        
        //dismiss(animated: false, completion: nil)
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { authResult, error in
            if(error == nil)
            {
                // Hurra. Registrering ok
                print("Registrering ok")
                self.dismiss(animated: false, completion: nil)
            } else {
                // Ajdå. Registrering fel
                print("Registrering fel")
            }
        }
    }
    
    @IBAction func loginUser(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { authResult, error in
            if(error == nil)
            {
                // Hurra. Login ok
                print("login ok")
                self.dismiss(animated: false, completion: nil)
            } else {
                // Ajdå. Login fel
                print("login fel")
            }
        }
        
    }
    
}
