//
//  ClockBuilder.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-03.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit
import CoreData
import UIKit


func DrawClockView(view: UIView) -> Void {
    
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
        

        let clockPictureView = UIImageView(frame: CGRect(x: 0, y: y, width: 250, height: 250))
        clockPictureView.backgroundColor = UIColor.red
        clockPictureView.image = crop(image: loadImage(fileName: "imageStep.jpg")!,withWidth: 2000, andHeight: 2000)!
        
        fullView.addSubview(clockPictureView)
        
        
        // Contour Title
        let contTitle = UILabel(frame: CGRect(x: 250, y: y, width: 125, height: 30))
        contTitle.text = "Contour"
        contTitle.textAlignment = .center
        contTitle.layer.borderWidth = 1
        LabelStyle(label: contTitle)
        
        fullView.addSubview(contTitle)
        
        // Contour Label
        
        let contLabel = UILabel(frame: CGRect(x: 250, y: y+30, width: 125, height: 53))
        contLabel.text = bool2String(b: subject?.clock?.contour)
        contLabel.textAlignment = .center
        contLabel.layer.borderWidth = 1
        
        fullView.addSubview(contLabel)
        
        
        // Numbers Title
        let numTitle = UILabel(frame: CGRect(x: 250, y: y+83, width: 125, height: 30))
        numTitle.text = "Numbers"
        LabelStyle(label: numTitle)
        fullView.addSubview(numTitle)
        
        
        // Numbers Label
        let numLabel = UILabel(frame: CGRect(x: 250, y: y+113, width: 125, height: 53))
        numLabel.text = bool2String(b: subject?.clock?.numbers)
        NumberStyle(label: numLabel)
        fullView.addSubview(numLabel)
        
        // Hands Title
        let handTitle = UILabel(frame: CGRect(x: 250, y: y+166, width: 125, height: 30))
        handTitle.text = "Hands"
        LabelStyle(label: handTitle)
        fullView.addSubview(handTitle)
        
        // Hands Label
        let handLabel = UILabel(frame: CGRect(x: 250, y: y+196, width: 125, height: 54))
        handLabel.text = bool2String(b: subject?.clock?.hands)
        LabelStyle(label: handLabel)
        fullView.addSubview(handLabel)
        
        fullView.tag = 100
        
        view.addSubview(fullView)
    
        PersistenceService.saveContext()
    }
    catch{ print("Insert error view controlle here")}
}
