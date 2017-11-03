//
//  SleepTask.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-06.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit



public var SleepTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    
    
    
    
    //TODO: add instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "DOC Apnea"
    instructionStep.text = "You will be asked questions about your sleep apnea."
    steps += [instructionStep]
    
    // Four questions on the doc screen
    
    // 1st
    let step1Title = "Do you snore loudly (louder than talking, heard through a door, or bother other people)?"
    
    let step1answerFormat = ORKBooleanAnswerFormat()
    let step1Question = ORKQuestionStep(identifier: "loudQuestion", title: step1Title, answer: step1answerFormat)
    
    steps += [step1Question]
    
    //2nd
    let step2Title = "Do you often feel tired, fatigued or sleepy during the daytime?"
    let step2answerFormat = ORKBooleanAnswerFormat()
    let step2Question = ORKQuestionStep(identifier: "fatigueQuestion", title: step2Title, answer: step2answerFormat)
    
    steps += [step2Question]
    
    
    
    //3rd
    let step3Title = "Has anyone observed you stop breathing during your sleep?"
    let step3answerFormat = ORKBooleanAnswerFormat()
    let step3Question = ORKQuestionStep(identifier: "breathQuestion", title: step3Title, answer: step3answerFormat)
    
    steps += [step3Question]
    
    
    
    //4th
    let step4Title = "Do you have, or are you being treated for high blood pressure?"
    let step4answerFormat = ORKBooleanAnswerFormat()
    let step4Question = ORKQuestionStep(identifier: "bloodQuestion", title: step4Title, answer: step4answerFormat)
    
    steps += [step4Question]
    
    
    
    return ORKOrderedTask(identifier: "SleepTask", steps: steps)
}

