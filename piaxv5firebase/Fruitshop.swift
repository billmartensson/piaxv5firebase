//
//  Fruitshop.swift
//  piaxv5firebase
//
//  Created by Bill Martensson on 2021-10-25.
//

import Foundation

class Fruitshop {
    var fruitname = ""
    var fruitamount = ""
    
    func fancyamount() -> String {
        
        if(fruitamount == "")
        {
            return ""
        }
        
        return " " + fruitamount + " stycken"
    }
    
}
