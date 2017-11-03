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
    
    let trial1QuestionStepTitle = "Memory Trial - WithoutCue"
    let trial1textChoices = [
        ORKTextChoice(text: "FACE", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "VELVET", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "CHURCH", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "DAISY", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "RED", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let trial1AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: trial1textChoices)
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
    let trial3QuestionStep = ORKQuestionStep(identifier: "trialMutipleStep", title: trial3QuestionStepTitle, answer: trial3AnswerFormat)
    
    steps += [trial3QuestionStep]
    
    let summaryStep = ORKCompletionStep(identifier: "Memory Task - End")
    summaryStep.title = "Thank you."
    
    steps += [summaryStep]
    
    let task =  ORKNavigableOrderedTask(identifier: "MemoryTask", steps: steps)
    
    // Adding in rules
    let AnswerArray = [0 as NSCoding & NSCopying & NSObjectProtocol,
                       1 as NSCoding & NSCopying & NSObjectProtocol,
                       2 as NSCoding & NSCopying & NSObjectProtocol,
                       3 as NSCoding & NSCopying & NSObjectProtocol,
                       4 as NSCoding & NSCopying & NSObjectProtocol]
    
    let withoutCuePredicate = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: "trialWithoutCueStep"), expectedAnswerValues: AnswerArray)
    
    let categoryCuePredicate = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: "trialCategoryStep"), expectedAnswerValues: AnswerArray)
    
    
    let multipleChoicePredicate = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: "trialMultipleStep"), expectedAnswerValues: AnswerArray)
    

    let withoutCueRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(withoutCuePredicate, "summaryStep")])
    
    let categoryCueRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(categoryCuePredicate, "summaryStep")])
     let multipleCueRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(multipleChoicePredicate, "summaryStep")])
    
    
    task.setNavigationRule(withoutCueRule, forTriggerStepIdentifier: "trialWithoutCueStep")
    
    task.setNavigationRule(categoryCueRule, forTriggerStepIdentifier: "trialCategoryStep")
    
    task.setNavigationRule(multipleCueRule, forTriggerStepIdentifier: "trialMultipleStep")
    
    
    return task
}



