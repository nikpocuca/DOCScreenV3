//
//  DataStorage.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-13.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import UIKit


struct DataStorage {

    
    static var name: String = ""
    static var sex: String = ""
    static var date: String = ""
    static var education: String = ""
    static var age: Int = -1
    static var weight: Int = -1
    static var height: CGFloat = -1
    static var BMI: CGFloat = -1
    
    static var moodScore: Int = -1
    static var apneaScore: Int = -1
    static var memoryScore: Int = -1
    static var abstractScore: Int = -1
    static var clockScore: Int = -1
    
    static var clockImage: UIImage = #imageLiteral(resourceName: "white")
    
    
}

struct ClockData {
    static var contour: Int = -1;
    static var numbers: Int = -1;
    static var hands: Int = -1;
}





func dataPass(name: String, value: String) {
    
    func str2Float(num: String) -> CGFloat {
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: num)!
        let numberFloatValue = number.floatValue
        
        return CGFloat(numberFloatValue)
    }
    
    
    switch name {
    case "name": DataStorage.name = value
    case "sex": DataStorage.sex = value
    case "education": DataStorage.education = value
    case "age": DataStorage.age  = Int(value)!
    case "weight": DataStorage.weight = Int(value)!
    case "height": DataStorage.height = str2Float(num: value)
    case "BMI" : do { let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: value)!
        let numberFloatValue = number.floatValue
        let cgFloat = CGFloat(numberFloatValue)
        
        DataStorage.BMI = round(1000 * cgFloat) / 1000
        
        }
    default: print("No case")
    }

    
    
}

