//
//  ViewController.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-10-04.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var addfruitTextfield: UITextField!
    @IBOutlet weak var addfruitamountTextfield: UITextField!
    
    
    @IBOutlet weak var fruitTableview: UITableView!
    
    var currentplace = Fruitplace()
    
    var fruits = [Fruitshop]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("NU HÄNDER viewDidLoad")
        
        addfruitTextfield.delegate = self
        addfruitamountTextfield.delegate = self
        
        /*
        fruits.append("Banan")
        fruits.append("Apelsin")
        fruits.append("Kiwi")
        */

        ref = Database.database().reference()
        
        
        
        self.ref.child("tjena").setValue("hepp")
        
        
        
        
        var fancybuy = Fruitshop()
        fancybuy.fruitname = "Papaya"
        fancybuy.fruitamount = "7"
        
        var anotherthing = Fruitshop()
        anotherthing.fruitname = "Banan"
        anotherthing.fruitamount = "4"
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("NU HÄNDER viewDidAppear")
        
        if(Auth.auth().currentUser == nil)
        {
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            print("Inloggad")
            print(Auth.auth().currentUser?.uid)
            loadfruits()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("NU HÄNDER viewDidDisappear")
    }
    
    func loadfruits() {
        var loadpath = ref.child("fruitshopping")
        
        loadpath = loadpath.child(Auth.auth().currentUser!.uid)
        loadpath = loadpath.child("fruits")
        
        loadpath.queryOrdered(byChild: "fruitplace").queryEqual(toValue: currentplace.fbid).observeSingleEvent(of: .value, with: { snapshot in
            
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
            
          }) { error in
            print(error.localizedDescription)
          }
        
        /*
        loadpath.queryOrdered(byChild: "fruitplace").getData(completion: { error, snapshot in
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
         */
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == addfruitTextfield)
        {
            addfruitamountTextfield.becomeFirstResponder()
        }
        if(textField == addfruitamountTextfield)
        {
            letsAddStuff()
        }
        
        return true
    }
    
    @IBAction func addFruit(_ sender: Any) {
        letsAddStuff()
    }
    
    
    @IBAction func logoutuser(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "login", sender: nil)
            
        } catch {
            
        }
        
        
    }
    
    func letsAddStuff() {
        if(addfruitTextfield.text != "")
        {
            //fruits.append(addfruitTextfield.text!)
            
            //fruitTableview.reloadData()
            
            var fruitinfo = [String : String]()
            fruitinfo["fruitplace"] = currentplace.fbid
            fruitinfo["fruitname"] = addfruitTextfield.text
            fruitinfo["fruitamount"] = addfruitamountTextfield.text
            
            
            self.ref.child("fruitshopping").child(Auth.auth().currentUser!.uid).child("fruits").childByAutoId().setValue(fruitinfo) {
                (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                    } else {
                        print("Data saved successfully!")
                        self.loadfruits()
                    }
                }

            

            
            addfruitTextfield.text = ""
            addfruitamountTextfield.text = ""
            
        } else {
            // Textfältet var tomt
            // Create new Alert
            var dialogMessage = UIAlertController(title: "Fel", message: "Du måste skriva namn på frukten", preferredStyle: .alert)

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
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "raden") as! RadenTableViewCell
        
        let currentfruit = fruits[indexPath.row]
        
        cell.radLabel.text = currentfruit.fruitname + currentfruit.fancyamount()
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        print("Klickat på en rad " + String(indexPath.row))
        
        performSegue(withIdentifier: "moreinfo", sender: fruits[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "moreinfo")
        {
            let dest = segue.destination as! MoreinfoViewController
                        
            dest.fruitinfo = sender as! Fruitshop
        }
        
    }

}

