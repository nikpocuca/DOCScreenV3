//
//  MemoryBuilder.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-03.
//  Copyright © 2018 Nik. All rights reserved.
//


import Foundation
import ResearchKit
import CoreData
import UIKit


func DrawMemoryView(view: UIView, viewController: UIViewController) -> Void {
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // theres only one subject.
        let subject = subjectArray.first
    
        // Style Function
        func LabelStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.font = UIFont(name: "HelveticaNeue", size: 16)
            label.textColor = UIColor.red
        }
    
        func BorderHolderStyle(view: UIView) -> Void{
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.cornerRadius = 16
            
        }
    
        func NumberStyle(label: UILabel) -> Void {
            label.textAlignment = .center
            label.layer.borderWidth = 1
            label.font = UIFont(name: "HelveticaNeue", size: 18)
        }
    
        func ImageStyle(label: UIImageView) -> Void {
            label.backgroundColor = UIColor.red
            label.layer.borderWidth = 5
            label.layer.cornerRadius = 20
            label.layer.borderColor = UIColor.red.cgColor
            label.contentMode = .center
        }
    
        let y = view.frame.origin.y - 10
    
        let fullView = UIView(frame: CGRect(x: 0, y: y, width: 375, height: 200))
    
        let faceImage = UIImageView(frame: CGRect(x: 0, y: y - 5, width: 75, height: 75))
        ImageStyle(label: faceImage)
        faceImage.image = #imageLiteral(resourceName: "faceIcon")
    
    
        let velvetImage = UIImageView(frame: CGRect(x: 75, y: y - 5, width: 75, height: 75))
        ImageStyle(label: velvetImage)
        velvetImage.image = #imageLiteral(resourceName: "velvetIcon")
    
        let churchImage = UIImageView(frame: CGRect(x: 150, y: y - 5, width: 75, height: 75))
        ImageStyle(label: churchImage)
        churchImage.image = #imageLiteral(resourceName: "churchIcon")
    
        let daisyImage = UIImageView(frame: CGRect(x: 225, y: y - 5 , width: 75, height: 75))
        ImageStyle(label: daisyImage)
        daisyImage.image = #imageLiteral(resourceName: "flowerIcon ")
    
        let redImage = UIImageView(frame: CGRect(x: 300, y: y - 5, width: 75, height: 75))
        ImageStyle(label: redImage)
    
        let faceLabel = UILabel(frame: CGRect(x: 0, y: y+70,width: 75, height: 75))
        LabelStyle(label: faceLabel)
        faceLabel.text = bool2String(b: subject?.memory?.faceWC)
    
        let velvetLabel = UILabel(frame: CGRect(x: 75, y: y+70,width: 75, height: 75))
        LabelStyle(label: velvetLabel)
        velvetLabel.text = bool2String(b: subject?.memory?.velvetWC)
    
        let churchLabel = UILabel(frame: CGRect(x: 150, y: y+70,width: 75, height: 75))
        LabelStyle(label: churchLabel)
        churchLabel.text = bool2String(b: subject?.memory?.churchWC)
    
        let daisyLabel = UILabel(frame: CGRect(x: 225, y: y+70, width: 75, height: 75))
        LabelStyle(label: daisyLabel)
        daisyLabel.text = bool2String(b: subject?.memory?.daisyWC)
    
        let redLabel = UILabel(frame: CGRect(x: 300, y: y+70, width: 75, height: 75))
        LabelStyle(label: redLabel)
        redLabel.text = bool2String(b: subject?.memory?.redWC)
    
    
        let faceHolder =  UIView(frame: CGRect(x: 0, y: y, width: 75, height: 143))
        BorderHolderStyle(view: faceHolder)
    
        let velvetHolder =  UIView(frame: CGRect(x: 75, y: y, width: 75, height: 143))
        BorderHolderStyle(view: velvetHolder)
    
        let churchHolder =  UIView(frame: CGRect(x: 150, y: y, width: 75, height: 143))
        BorderHolderStyle(view: churchHolder)
    
        let daisyHolder =  UIView(frame: CGRect(x: 225, y: y, width: 75, height: 143))
        BorderHolderStyle(view: daisyHolder)
    
        let redHolder =  UIView(frame: CGRect(x: 300, y: y, width: 75, height: 143))
        BorderHolderStyle(view: redHolder)
    
        fullView.addSubview(faceImage)
        fullView.addSubview(velvetImage)
        fullView.addSubview(churchImage)
        fullView.addSubview(daisyImage)
        fullView.addSubview(redImage)
        fullView.addSubview(faceLabel)
        fullView.addSubview(faceHolder)
        fullView.addSubview(velvetLabel)
        fullView.addSubview(velvetHolder)
        fullView.addSubview(churchLabel)
        fullView.addSubview(churchHolder)
        fullView.addSubview(daisyLabel)
        fullView.addSubview(daisyHolder)
        fullView.addSubview(redLabel)
        fullView.addSubview(redHolder)
    
        fullView.tag = 600
    
        view.addSubview(fullView)
    
        PersistenceService.saveContext()
    }
    catch{   viewController.present(callError(), animated: true, completion: nil)}
}




