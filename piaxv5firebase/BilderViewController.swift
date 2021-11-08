//
//  BilderViewController.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-11-08.
//

import UIKit

class BilderViewController: UIViewController {

    
    @IBOutlet weak var bilden: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func letsChangeImage(_ sender: Any) {
        
        bilden.image = UIImage(named: "theotherone")
        
    }
    
    

}
