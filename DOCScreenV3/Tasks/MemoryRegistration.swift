//
//  MemoryTask.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-06.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit

public var MemoryRegistrationTask: ORKOrderedTask{
    
    var steps = [ORKStep]()
    
    // Instruction step.
    let instructionStep = ORKInstructionStep(identifier: "prelimStep")
    instructionStep.title = "Memory Registration"
    instructionStep.text = "I am going to read a list of words that you will have to remember now and later on. Listen carefully, When I am through, tell me as many words as you can remember"
    steps += [instructionStep]
    
    let trial1QuestionStepTitle = "Memory Trial - 1"
    let trial1textChoices = [
        ORKTextChoice(text: "FACE", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "VELVET", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "CHURCH", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "DAISY", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "RED", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let trial1AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: trial1textChoices)
    let trial1QuestionStep = ORKQuestionStep(identifier: "trial1RegistrationTextChoiceQuestionStep", title: trial1QuestionStepTitle, answer: trial1AnswerFormat)
    
    steps += [trial1QuestionStep]
    
    let trial2QuestionStepTitle = "Memory Trial - 2"
    let trial2textChoices = [
        ORKTextChoice(text: "FACE", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "VELVET", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "CHURCH", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "DAISY", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "RED", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let trial2AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: trial2textChoices)
    let trial2QuestionStep = ORKQuestionStep(identifier: "trial2RegistrationTextChoiceQuestionStep", title: trial2QuestionStepTitle, answer: trial2AnswerFormat)
    
    steps += [trial2QuestionStep]
    
    
    return ORKOrderedTask(identifier: "MemoryRegistrationTask", steps: steps)
}



