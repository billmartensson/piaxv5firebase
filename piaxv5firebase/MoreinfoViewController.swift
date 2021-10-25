//
//  MoreinfoViewController.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-10-04.
//

import UIKit

class MoreinfoViewController: UIViewController {

    
    @IBOutlet weak var infoLabel: UILabel!
    
    var fruitinfo = Fruitshop()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        infoLabel.text = fruitinfo.fruitname
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
