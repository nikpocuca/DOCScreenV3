//
//  MemoryTask.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-06.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit

public var MemoryTask: ORKOrderedTask{
    
    var steps = [ORKStep]()
    
    // Instruction step.
    let instructionStep = ORKInstructionStep(identifier: "prelimStep")
    instructionStep.title = "Memory Task"
    instructionStep.text = "In a moment I will ask you to recall any of the words I mentioned prior, please take your time."
    steps += [instructionStep]
    
    
    let memoryQuestions = ORKFormStep(identifier: "memoryQuestions")
    
    let trial1QuestionStepTitle = "Memory Trial - WithoutCue"
    let trial1textChoices = [
        ORKTextChoice(text: "FACE", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "VELVET", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "CHURCH", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "DAISY", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "RED", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let trial1AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: trial1textChoices)
    
    let trial1FormItem = ORKFormItem(identifier: "trialWithoutCueStep", text: "Without Cue", answerFormat: trial1AnswerFormat, optional: true)
    
    let trial1QuestionStep = ORKQuestionStep(identifier: "trialWithoutCueStep", title: trial1QuestionStepTitle, answer: trial1AnswerFormat)
    
    steps += [trial1QuestionStep]
    
    let trial2QuestionStepTitle = "Memory Trial - Category Cue"
    let trial2textChoices = [
        ORKTextChoice(text: "FACE", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "VELVET", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "CHURCH", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "DAISY", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "RED", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let trial2AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: trial2textChoices)
    
    let trial2FormStep = ORKFormItem(identifier: "trialCategoryStep", text: "Category Cue", answerFormat: trial2AnswerFormat, optional: true)
    
    let trial2QuestionStep = ORKQuestionStep(identifier: "trialCategoryStep", title: trial2QuestionStepTitle, answer: trial2AnswerFormat)
    
    steps += [trial2QuestionStep]
    
    
    let trial3QuestionStepTitle = "Memory Trial - Mulitple Choice Cue"
    let trial3textChoices = [
        ORKTextChoice(text: "FACE", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "VELVET", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "CHURCH", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "DAISY", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "RED", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let trial3AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: trial3textChoices)
    
    
    let trial3FormStep = ORKFormItem(identifier: "trialMultipleStep", text: "Multiple Choice Cue", answerFormat: trial3AnswerFormat, optional: true)
    
    let trial3QuestionStep = ORKQuestionStep(identifier: "trialMutipleStep", title: trial3QuestionStepTitle, answer: trial3AnswerFormat)
    
    trial3QuestionStep.isOptional = false
    
    steps += [trial3QuestionStep]
    
    let summaryStep = ORKCompletionStep(identifier: "Memory Task - End")
    summaryStep.title = "Thank you."
    
    steps += [summaryStep]
    
    memoryQuestions.formItems = [trial1FormItem,trial2FormStep,trial3FormStep]
    
    let newSteps = [instructionStep,memoryQuestions]
    
    let task =  ORKNavigableOrderedTask(identifier: "MemoryTask", steps: newSteps)
    
    return task
}



