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
    
    var fruits = [String]()
    var fruitamount = [String]()
    

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
                self.fruits.append(fruktinfo["fruitname"]!)
            }
            
            DispatchQueue.main.async {
                self.fruitTableview.reloadData()
            }
            
            
        })
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
            fruits.append(addfruitTextfield.text!)
            
            fruitTableview.reloadData()
            
            var fruitinfo = [String : String]()
            fruitinfo["fruitname"] = addfruitTextfield.text
            fruitinfo["fruitamount"] = addfruitamountTextfield.text
            
            
            self.ref.child("fruitshopping").child(Auth.auth().currentUser!.uid).child("fruits").childByAutoId().setValue(fruitinfo)

            

            
            addfruitTextfield.text = ""
            addfruitamountTextfield.text = ""
            
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "raden") as! RadenTableViewCell
        
        cell.radLabel.text = fruits[indexPath.row]
        
        
        
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
            
            dest.infotext = sender as! String
        }
        
        
    }

}

