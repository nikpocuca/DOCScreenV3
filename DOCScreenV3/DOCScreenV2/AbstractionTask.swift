//
//  AbstractionTask.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-06.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit


public var AbstractionTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    // Instruction step.
    let instructionStep = ORKInstructionStep(identifier: "prelimStep")
    instructionStep.title = "Abstraction"
    instructionStep.text = "In this task you will have to state the similairities between two objects. E.g. How are an orange and banana alike? "
    steps += [instructionStep]
    

    
    let transportAnswerFormat = ORKBooleanAnswerFormat(yesString: "Correct", noString: "Incorrect")
    let transportTitle = "Transportation Question"
    let transportText = "How are a train and bicycle alike?"
    let transportStep = ORKQuestionStep(identifier: "transportStep", title: transportTitle, text: transportText, answer: transportAnswerFormat)

    steps += [transportStep]
    
    let measureAnswerFormat = ORKBooleanAnswerFormat(yesString: "Correct", noString: "Incorrect")
    let measureTitle = "Measurement Question"
    let measureText = "How are a watch and ruler alike?"
    let measureStep = ORKQuestionStep(identifier: "measureStep", title: measureTitle, text: measureText, answer: measureAnswerFormat)
    
    steps += [measureStep]
    
    


    return ORKOrderedTask(identifier: "AbstractionTask", steps: steps)
}
