//
//  BilderViewController.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-11-08.
//

import UIKit
import Firebase
import FirebaseStorage

class BilderViewController: UIViewController {

    
    @IBOutlet weak var bilden: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let frogplace = storageRef.child("frog.jpg")
        
        frogplace.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("OH NO ERROR")
            } else {
                // Data for "images/island.jpg" is returned
                let thedownloadedimage = UIImage(data: data!)
                
                self.bilden.image = thedownloadedimage
            }
        }
    }
    
    @IBAction func letsChangeImage(_ sender: Any) {
        
        bilden.image = UIImage(named: "theotherone")
        
    }
    
    

}
