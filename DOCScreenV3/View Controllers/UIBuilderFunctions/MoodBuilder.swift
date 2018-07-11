//
//  MoodBuilder.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-03.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit
import CoreData
import UIKit


func DrawMoodView(view: UIView, viewController: UIViewController) -> Void{
    
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
            label.font = UIFont(name: "HelveticaNeue", size: 20)
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.red
            
        }
        
        func NumberStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.layer.borderWidth = 0.5
            label.textColor = UIColor.red
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.cornerRadius = 10
            label.font = UIFont(name: "HelveticaNeue", size: 20)
        }
        
        
        // Disinterest Title
        let interestTitle = UILabel(frame: CGRect(x: 0, y: y, width: 125, height: 30))
        LabelStyle(label: interestTitle)
        interestTitle.text = "Disinterest"
        
        fullView.addSubview(interestTitle)
        
        // Depression Title
        let depTitle = UILabel(frame: CGRect(x: 125, y: y, width: 125, height: 30))
        LabelStyle(label: depTitle)
        depTitle.text = "Depression"
        
        fullView.addSubview(depTitle)
        
        // Score
        let scoreTitle = UILabel(frame: CGRect(x: 250, y: y, width: 125, height: 30))
        LabelStyle(label: scoreTitle)
        scoreTitle.text = "Score"
        
        fullView.addSubview(scoreTitle)
        
        // disinterest Num label
        let numLabel = UILabel(frame: CGRect(x: 0, y: y + 30, width: 125, height: 70))
        NumberStyle(label: numLabel)
        numLabel.text = "\((subject?.mood?.q1Mood)!)"
        
        fullView.addSubview(numLabel)
        
        // depression Number label.
        let depNumLabel = UILabel(frame: CGRect(x: 125, y: y + 30, width: 125, height: 70))
        NumberStyle(label: depNumLabel)
         depNumLabel.text = "\((subject?.mood?.q2Mood)!)"
        
        fullView.addSubview(depNumLabel)
        
        let scoreNumLabel = UILabel(frame: CGRect(x: 250, y: y + 30, width: 125, height: 70))
        NumberStyle(label: scoreNumLabel)
        scoreNumLabel.text = "\((subject?.mood?.moodScore)!)"
        
        fullView.addSubview(scoreNumLabel)
        
        fullView.tag = 300
        
        view.addSubview(fullView)
        
        PersistenceService.saveContext()
    }
    catch{ viewController.present(callError(), animated: true, completion: nil)}
}
