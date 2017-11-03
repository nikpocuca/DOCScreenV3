//
//  ProfileTask.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-06.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit


public var ProfileTask: ORKOrderedTask{
    
    var steps = [ORKStep]()
    
    // Instruction step.
    let instructionStep = ORKInstructionStep(identifier: "prelimStep")
    instructionStep.title = "Preliminary Questions"
    instructionStep.text = "You will be asked questions about your demographic and baseline health information"
    steps += [instructionStep]
    
    // Name Question
    let nameTitle = "What is your name?"
    let nameAnswerFormat = ORKTextAnswerFormat()
    let nameStep = ORKQuestionStep(identifier: "nameStep", title: nameTitle, answer: nameAnswerFormat)
    
    steps += [nameStep]
    
    // Age Question
    
    let ageTitle = "What is your age in years?"
    let ageAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "years")
    let ageStep = ORKQuestionStep(identifier: "ageStep", title: ageTitle, answer: ageAnswerFormat)
    
    steps += [ageStep]
    
    // Sex Question
    let sexAnswerFormat = ORKBooleanAnswerFormat(yesString: "Male", noString: "Female")
    let sexTitle = "Sex Question"
    let sexText = "What is your sex?"
    let sexStep = ORKQuestionStep(identifier: "sexStep", title: sexTitle, text: sexText, answer: sexAnswerFormat)

    steps += [sexStep]
    
    // Education Question
    
    let eduTitle = "What is your education in years?"
    let eduAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "years")
    let eduStep = ORKQuestionStep(identifier: "educationStep", title: eduTitle, answer: eduAnswerFormat)
    
    steps += [eduStep]
    
    // Height Question
    
    let heightFormTitle = "Height Information"
 
    let heightAnswerFormat = ORKNumericAnswerFormat(style: .decimal, unit: "")
    
    let heightUnitTextChoices = [
        ORKTextChoice(text: "inches", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "cm", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    
    let heightUnitFormat = ORKValuePickerAnswerFormat(textChoices: heightUnitTextChoices)
    
    let heightFormStep = ORKFormStep(identifier: "heightStep", title: heightFormTitle, text: "")

    let heightUnitItem = ORKFormItem(identifier: "heightUnitItem", text: "Unit", answerFormat: heightUnitFormat)
    let heightAnswerItem  = ORKFormItem(identifier: "heightAnswerItem", text: "Height", answerFormat: heightAnswerFormat)
    
    heightFormStep.formItems = [heightUnitItem,heightAnswerItem]

    steps += [heightFormStep]
    
    // Weight Question

    let w8formTitle = "Weight Information"
    
    let w8FormStep = ORKFormStep(identifier: "weightStep", title: w8formTitle, text: "")
    

    let w8UnitTextChoices = [
    ORKTextChoice(text: "kg", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "lbs", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    
    let w8UnitAnswer = ORKValuePickerAnswerFormat(textChoices: w8UnitTextChoices)

    let w8unitItem = ORKFormItem(identifier: "w8UnitItem", text: "Unit", answerFormat: w8UnitAnswer)
    
    let w8AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "")

    
    let w8AnswerItem = ORKFormItem(identifier: "weightAnswerItem", text: "Weight of subject:", answerFormat: w8AnswerFormat)
    
    w8FormStep.formItems = [w8unitItem,w8AnswerItem]
    
    steps += [w8FormStep]
    
    
    // BMI Question


    return ORKOrderedTask(identifier: "ProfileTask", steps: steps)
}

