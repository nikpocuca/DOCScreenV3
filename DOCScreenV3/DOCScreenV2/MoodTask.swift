//
//  MoodTask.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-06.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit


public var MoodTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    

    
    //TODO: add instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "DOC Mood"
    instructionStep.text = "You will be asked questions about your mood."
    steps += [instructionStep]
    
    
    
    // Question 1
    
    
    let step1title = "Over the last 2 weeks, how often have you had little interest or reduced pleasure in doing things?"
    let stepTextChoices = [ORKTextChoice(text: "Not at all", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                            ORKTextChoice(text: "Several days", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                            ORKTextChoice(text: "More than half the days", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                            ORKTextChoice(text: "Nearly every day", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    
    
    let step1AnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: stepTextChoices)
    
    let step1QuestionStep = ORKQuestionStep(identifier: "moodChoiceQuestion1Step", title: step1title, answer: step1AnswerFormat)
    
    steps += [step1QuestionStep]
    
    // Question 2
    
    
    let step2title = "Over the last 2 weeks, how often have you been feeling down, depressed or hopeless?"
    
    let step2AnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: stepTextChoices )
    
    let step2QuestionStep = ORKQuestionStep(identifier: "moodChoiceQuestion2Step", title: step2title, answer: step2AnswerFormat)
    
    
    steps += [step2QuestionStep]
    

    
    return ORKOrderedTask(identifier: "MoodTask", steps: steps)
}




