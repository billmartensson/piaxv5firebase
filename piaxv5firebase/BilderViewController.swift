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
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        
        let bildenattladdaupp = UIImage(named: "theotherone")
        
        
        
        // Data in memory
        let bilddatan = bildenattladdaupp!.jpegData(compressionQuality: 0.8)
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("testbild.jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(bilddatan!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("UPLOAD FAIL")
                return
            }
            print("UPLOAD OK")
            
        }
        
        
    }
    
    
    
}
