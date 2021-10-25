//
//  MoreinfoViewController.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-10-04.
//

import UIKit
import Firebase

class MoreinfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!

    var ref: DatabaseReference!
    
    var fruitinfo = Fruitshop()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        infoLabel.text = fruitinfo.fruitname
    }
    

    @IBAction func deleteFruit(_ sender: Any) {
        
        
        
        
        
        
        // Create new Alert
        var dialogMessage = UIAlertController(title: "Radera", message: "Är du säker på att du vill radera?", preferredStyle: .alert)

        // Create OK button with action handler
        let yesButton = UIAlertAction(title: "Ja", style: .destructive, handler: { (action) -> Void in
            print("JA button tapped")
            
            var fruitdeletepath = self.ref.child("fruitshopping")
            fruitdeletepath = fruitdeletepath.child(Auth.auth().currentUser!.uid).child("fruits")
            fruitdeletepath = fruitdeletepath.child(self.fruitinfo.fbid)
            
            fruitdeletepath.removeValue()
            
            //self.ref.child("fruitshopping").child(Auth.auth().currentUser!.uid).child("fruits").child(fruitinfo.fbid).removeValue()
            
            self.navigationController?.popViewController(animated: true)
            
            
        })

        let noButton = UIAlertAction(title: "Nej", style: .cancel, handler: { (action) -> Void in
            print("NEJ button tapped")
        })

        
        //Add OK button to a dialog message
        dialogMessage.addAction(noButton)
        dialogMessage.addAction(yesButton)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
        
        
    }
    

}
