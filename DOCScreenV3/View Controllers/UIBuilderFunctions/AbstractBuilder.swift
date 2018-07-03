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

func DrawAbstractView(view: UIView) -> Void {
    
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
        label.font = UIFont(name: "HelveticaNeue", size: 20)
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
    LabelStyle(label: transResponse)
    transResponse.text = "Correct"
    
    let measurementResponse = UILabel(frame: CGRect(x: 187.5, y: y + 50, width: 187.5, height: 90))
    LabelStyle(label: measurementResponse)
    measurementResponse.text = "Incorrect"
    
    
    fullView.addSubview(transResponse)
    fullView.addSubview(measurementResponse)

    fullView.tag = 400
    
    view.addSubview(fullView)
    
    testData()
}
