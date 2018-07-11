//
//  ApneaBuilder.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-03.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit
import CoreData
import UIKit

func DrawApneaView(view: UIView, viewController: UIViewController) -> Void {
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // theres only one subject.
        let subject = subjectArray.first
        
        // Style Function
        func LabelStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.backgroundColor = UIColor.red
            label.textColor = UIColor.white
            label.layer.cornerRadius = 5
            label.font = UIFont(name: "HelveticaNeue", size: 17)
        }
        
        func NumberStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.layer.borderWidth = 0.5
            label.textColor = UIColor.red
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.cornerRadius = 10
            label.font = UIFont(name: "HelveticaNeue", size: 18)
        }
        
        let y = view.frame.origin.y - 30
        
        let fullView = UIView(frame: CGRect(x: 0, y: y, width: 375, height: 200))
        
        let snoreTitle = UILabel(frame: CGRect(x: 0, y: y, width: 93.75, height: 40))
        LabelStyle(label: snoreTitle)
        snoreTitle.text = "Snoring"
        
        let fatigueTitle = UILabel(frame: CGRect(x: 93.75, y: y, width: 93.75, height: 40))
        LabelStyle(label: fatigueTitle)
        fatigueTitle.text = "Fatigue"
        
        let observeTitle = UILabel(frame: CGRect(x: 187.5, y: y, width: 93.75, height: 40))
        LabelStyle(label: observeTitle)
        observeTitle.text = "Observed"
        
        let highBPTitle = UILabel(frame: CGRect(x: 281.25, y: y, width: 93.75, height: 40))
        LabelStyle(label: highBPTitle)
        highBPTitle.text = "High BP"
        
        let snoreLabel = UILabel(frame: CGRect(x: 0, y: y+40, width: 93.75, height: 60))
        NumberStyle(label: snoreLabel)
        snoreLabel.text = bool2String(b: subject?.apnea?.q1Score)
        
        let fatigueLabel = UILabel(frame: CGRect(x: 93.75, y: y+40, width: 93.75, height: 60))
        NumberStyle(label: fatigueLabel)
        fatigueLabel.text = bool2String(b: subject?.apnea?.q2Score)
        
        let observeLabel = UILabel(frame: CGRect(x: 187.5, y: y+40, width: 93.75, height: 60))
        NumberStyle(label: observeLabel)
        observeLabel.text = bool2String(b: subject?.apnea?.q3Score)
        
        let highBPLabel = UILabel(frame: CGRect(x: 281.25, y: y+40, width: 93.75, height: 60))
        NumberStyle(label: highBPLabel)
        highBPLabel.text = bool2String(b: subject?.apnea?.q4Score)
        
        
        fullView.addSubview(snoreTitle)
        fullView.addSubview(fatigueTitle)
        fullView.addSubview(observeTitle)
        fullView.addSubview(highBPTitle)
        fullView.addSubview(snoreLabel)
        fullView.addSubview(fatigueLabel)
        fullView.addSubview(observeLabel)
        fullView.addSubview(highBPLabel)
        
        fullView.tag = 500
        
        view.addSubview(fullView)
        
        PersistenceService.saveContext()
        
    } catch{  viewController.present(callError(), animated: true, completion: nil) }
}
