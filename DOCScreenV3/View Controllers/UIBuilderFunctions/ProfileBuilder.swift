//
//  ProfileBuilder.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-03.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit
import CoreData
import UIKit



func DrawProfileView(view: UIView) -> Void{
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // theres only one subject.
        let subject = subjectArray.first
        
        let y = view.frame.origin.y - 30
        
        let fullView = UIView(frame: CGRect(x: 0, y: y, width: 375, height: 200))
        
        // Style Function
        func LabelStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.layer.borderWidth = 1
            label.font = UIFont(name: "HelveticaNeue", size: 20)
        }
        
        func NumberStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.layer.borderWidth = 1
        }
        
        // Generate Age Title
        let ageTitleLabel = UILabel(frame: CGRect(x: 0, y: y, width: 125, height: 50))
        ageTitleLabel.text = "Age"
        ageTitleLabel.textAlignment = .center
        ageTitleLabel.layer.borderWidth = 1
        
        fullView.addSubview(ageTitleLabel)
        
        // Number of Age
        let ageNumberLabel = UILabel(frame: CGRect(x: 0, y: y+50, width: 125, height: 70))
        ageNumberLabel.text = String((subject?.age)!)
        ageNumberLabel.textAlignment = .center
        ageNumberLabel.layer.borderWidth = 1
        
        fullView.addSubview(ageNumberLabel)
        
        // Education Title
        let eduTitleLabel = UILabel(frame: CGRect(x: 125, y: y, width: 125, height: 50))
        eduTitleLabel.text = "Education"
        eduTitleLabel.textAlignment = .center
        eduTitleLabel.layer.borderWidth = 1
        LabelStyle(label: eduTitleLabel)
        
        fullView.addSubview(eduTitleLabel)
        
        // Education Number
        let eduNumberLabel = UILabel(frame: CGRect(x: 125, y: y+50, width: 125, height: 70))
        eduNumberLabel.text = String((subject?.education)!)
        eduNumberLabel.textAlignment = .center
        eduNumberLabel.layer.borderWidth = 1
        
        fullView.addSubview(eduNumberLabel)
        
        // Sex Title
        let sexTitle = UILabel(frame: CGRect(x: 250, y: y, width: 125, height: 50))
        sexTitle.text = "Sex"
        sexTitle.textAlignment = .center
        sexTitle.layer.borderWidth = 1
        LabelStyle(label: sexTitle)
        
        fullView.addSubview(sexTitle)
        
        // Sex Label
        
        func sexToString(inputBool: Bool) -> String{
            switch inputBool {
            case true:
                return("Male")
            default:
                return("Female")
            }
        }
        
        let sexLabel = UILabel(frame: CGRect(x: 250, y: y+50, width: 125, height: 70))
        sexLabel.text = sexToString(inputBool: (subject?.sex)!)
        sexLabel.textAlignment = .center
        sexLabel.layer.borderWidth = 1
        fullView.addSubview(sexLabel)
        
        
        // Weight Title
        let weightTitle = UILabel(frame: CGRect(x: 0, y: y+120, width: 125, height: 50))
        weightTitle.text = "Weight"
        LabelStyle(label: weightTitle)
        fullView.addSubview(weightTitle)
        
        // Height Title
        let heightTitle = UILabel(frame: CGRect(x: 125, y: y+120, width: 125, height: 50))
        heightTitle.text = "Height"
        LabelStyle(label: heightTitle)
        fullView.addSubview(heightTitle)
        
        // BMI Title
        let bmiTitle = UILabel(frame: CGRect(x: 250, y: y+120, width: 125, height: 50))
        bmiTitle.text = "BMI"
        LabelStyle(label: bmiTitle)
        fullView.addSubview(bmiTitle)
        
        // Weight Number
        let weightNumberLabel = UILabel(frame: CGRect(x: 0, y: y+170, width: 125, height: 70))
        weightNumberLabel.text = (subject?.weight)!
        NumberStyle(label: weightNumberLabel)
        fullView.addSubview(weightNumberLabel)
        
        // Height Number
        let heightNumberLabel = UILabel(frame: CGRect(x: 125, y: y+170, width: 125, height: 70))
        heightNumberLabel.text = (subject?.height)!
        NumberStyle(label: heightNumberLabel)
        fullView.addSubview(heightNumberLabel)
        
        func bmiToString(inputHeight: String, inputWeight: String) -> String {
            
            let heightStrings = inputHeight.split(separator: " ");
            let heightNumString = heightStrings[0];
            var heightUnitString = heightStrings[1];
            let height = NSNumber(value: Float(heightNumString)!)
            
            let weightStrings = inputWeight.split(separator: " ");
            let weightNumString = weightStrings[0];
            let weightUnitString = weightStrings[1];
            let weight = NSNumber(value: Float(weightNumString)!)
            
            var bmiFloat = weight.floatValue/(height.floatValue*height.floatValue)
            
            if heightUnitString == "cm" {bmiFloat = bmiFloat*10000
                heightUnitString = "m"
            }
                
            else {}
            
            let bmiNumString = String(bmiFloat)
            
            let bmiUnitString = weightUnitString + "/" + heightUnitString + "^2";
            
            let bmiString = bmiNumString + " " + bmiUnitString
            return (bmiString);
        }
        
        // BMI Number
        let bmiNumberLabel = UILabel(frame: CGRect(x: 250, y: y+170, width: 125, height: 70))
        bmiNumberLabel.text = bmiToString(inputHeight: (subject?.height)!, inputWeight: (subject?.weight)!)
        NumberStyle(label: bmiNumberLabel)
        fullView.addSubview(bmiNumberLabel)
        
        fullView.tag = 200
        
        view.addSubview(fullView)
    }
        
    catch {print("Place view Controller that says Alert there is no subject yet")}

    
}
