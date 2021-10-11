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
    
    @IBOutlet weak var fruitTableview: UITableView!
    
    var fruits = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addfruitTextfield.delegate = self
        
        fruits.append("Banan")
        fruits.append("Apelsin")
        fruits.append("Kiwi")
        

        ref = Database.database().reference()
        
        
        self.ref.child("tjena").setValue("hepp")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == addfruitTextfield)
        {
            letsAddStuff()
        }
        
        
        return true
    }
    
    @IBAction func addFruit(_ sender: Any) {
        letsAddStuff()
    }
    
    func letsAddStuff() {
        if(addfruitTextfield.text != "")
        {
            fruits.append(addfruitTextfield.text!)
            
            fruitTableview.reloadData()
            
            addfruitTextfield.text = ""
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
        let dest = segue.destination as! MoreinfoViewController
        
        dest.infotext = sender as! String
    }

}

