//
//  FruitplacesViewController.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-10-28.
//

import UIKit
import Firebase

class FruitplacesViewController: UIViewController, UITableViewDataSource {
    
    var ref: DatabaseReference!

    @IBOutlet weak var addplaceTextfield: UITextField!
    
    @IBOutlet weak var placesTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        
        placesTableview.dataSource = self
        
        
    }


    override func viewDidAppear(_ animated: Bool) {
        print("NU HÄNDER viewDidAppear")
        
        if(Auth.auth().currentUser == nil)
        {
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            print("Inloggad")
            print(Auth.auth().currentUser?.uid)
            loadplaces()
        }
    }
    
    @IBAction func addPlace(_ sender: Any) {
        letsAddStuff()
    }
    

    
    
    func letsAddStuff() {
        if(addplaceTextfield.text != "")
        {
            //fruits.append(addfruitTextfield.text!)
            
            //fruitTableview.reloadData()
            
            var placeinfo = [String : String]()
            placeinfo["placename"] = addplaceTextfield.text
            
            self.ref.child("fruitshopping").child(Auth.auth().currentUser!.uid).child("places").childByAutoId().setValue(placeinfo) {
                (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                    } else {
                        print("Data saved successfully!")
                        self.loadplaces()
                    }
                }

            addplaceTextfield.text = ""
            
        } else {
            // Textfältet var tomt
            // Create new Alert
            var dialogMessage = UIAlertController(title: "Fel", message: "Du måste skriva namn på platsen", preferredStyle: .alert)

            // Create OK button with action handler
            let ok = UIAlertAction(title: "Jepp", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })

            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            
        }
    }
    
    
    func loadplaces() {
        ref.child("fruitshopping").child(Auth.auth().currentUser!.uid).child("fruits").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }

            //snapshot.children
            
            self.fruits.removeAll()
            
            for fruktbarn in snapshot.children {
                let fruktbarnSnap = fruktbarn as! DataSnapshot
                
                let fruktinfo = fruktbarnSnap.value as! [String : String]
                
                print(fruktinfo["fruitname"])
                
                var tempfruit = Fruitshop()
                tempfruit.fbid = fruktbarnSnap.key
                tempfruit.fruitname = fruktinfo["fruitname"]!
                tempfruit.fruitamount = fruktinfo["fruitamount"]!

                
                self.fruits.append(tempfruit)
            }
            
            DispatchQueue.main.async {
                self.fruitTableview.reloadData()
            }
            
            
        })
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placerow") as! PlaceTableViewCell
        
        cell.placeLabel.text = "Hemma"
        
        return cell
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
