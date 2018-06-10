//
//  ClockTask.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-06.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit

public var ClockTask: ORKOrderedTask{
    
    var steps = [ORKStep]()
    
    // Instruction step.
    let instructionStep = ORKInstructionStep(identifier: "instructStep")
    instructionStep.title = "Drawing a clock"
    instructionStep.text = "Please take the pen and paper and draw a clock ten minutes past eleven."
    steps += [instructionStep]
    
    // capturing image
    let imageCaptureStep = ORKImageCaptureStep(identifier: "imageStep")
    imageCaptureStep.isOptional = false
    imageCaptureStep.accessibilityHint = ""
    imageCaptureStep.templateImage = #imageLiteral(resourceName: "target")
    imageCaptureStep.templateImageInsets = UIEdgeInsetsMake(0.35, 0.35, 0.35, 0.35)
    steps += [imageCaptureStep]
    
    return ORKOrderedTask(identifier: "ClockTask", steps: steps)

}


