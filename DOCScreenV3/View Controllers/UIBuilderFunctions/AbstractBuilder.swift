//
//  AbstractBuilder.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-03.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit
import CoreData
import UIKit

func DrawAbstractView(view: UIView, viewController: UIViewController) -> Void {
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // theres only one subject.
        let subject = subjectArray.first
        
        let y = view.frame.origin.y - 30
        
        let fullView = UIView(frame: CGRect(x: 0, y: y, width: 375, height: 200))
        
        // Style Function
        func LabelStyle(label: UILabel) -> Void {
            label.backgroundColor = UIColor.red
            label.textColor = UIColor.white
            label.layer.cornerRadius = 5
            label.textAlignment = .center
            label.font = UIFont(name: "HelveticaNeue", size: 20)
        }
        
        func NumberStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.layer.borderWidth = 0.5
            label.textColor = UIColor.red
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.cornerRadius = 10
            label.font = UIFont(name: "HelveticaNeue", size: 20)
        }
        
     
        
        
        func bool2String2(b: Bool?) -> String {
            switch b! {
            case true:
                return("Correct")
            default:
                return("Incorrect")
            }
        }

        
        let transTitle = UILabel(frame: CGRect(x: 0, y: y, width: 187.5, height: 50))
        LabelStyle(label: transTitle)
        transTitle.text = "Transportation"
        
        let measurementTitle = UILabel(frame: CGRect(x: 187.5, y: y, width: 187.5, height: 50))
        LabelStyle(label: measurementTitle)
        measurementTitle.text = "Measurement"
        
        fullView.addSubview(transTitle)
        fullView.addSubview(measurementTitle)
        
        let transResponse = UILabel(frame: CGRect(x: 0, y: y + 50, width: 187.5, height: 90))
        NumberStyle(label: transResponse)
        transResponse.text = bool2String2(b: subject?.abstract?.q1BoolScore)
        
        let measurementResponse = UILabel(frame: CGRect(x: 187.5, y: y + 50, width: 187.5, height: 90))
        NumberStyle(label: measurementResponse)
        measurementResponse.text = bool2String2(b: subject?.abstract?.q2BoolScore)
        
        fullView.addSubview(transResponse)
        fullView.addSubview(measurementResponse)

        fullView.tag = 400
        
        view.addSubview(fullView)
        
        PersistenceService.saveContext()
        
    } catch{    viewController.present(callError(), animated: true, completion: nil)}
}
