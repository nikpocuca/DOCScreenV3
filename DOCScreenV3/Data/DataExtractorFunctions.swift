//
//  DataExtractorFunctions.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-05-23.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit
import CoreData

// Extracts Profile and deletes previous one.

func ExtractProfile(taskController: ORKTaskViewController) {
    
    deleteSubjects()
    
    let subject = Subject(context: PersistenceService.context)
    
    // Parsing Name Result
    
    let nameResult = taskController.result.stepResult(forStepIdentifier: "nameStep")
    
    let textResult = nameResult?.firstResult as? ORKTextQuestionResult
    
    let name = textResult?.textAnswer!
    
    subject.name = name

    // Parsing Age Result
    
    let ageResult = taskController.result.stepResult(forStepIdentifier: "ageStep")
    
    let ageNumber = ageResult?.firstResult as? ORKNumericQuestionResult
    
    subject.age = (ageNumber?.numericAnswer?.int16Value)!
    
    // Parsing Sex Result
    
    let sexResult = taskController.result.stepResult(forStepIdentifier: "sexStep")
    
    let sexBool = sexResult?.firstResult as? ORKBooleanQuestionResult
    
    subject.sex = (sexBool?.booleanAnswer?.boolValue)!
    
    // Parsing Education Result
    
    let educationResult = taskController.result.stepResult(forStepIdentifier: "educationStep")
    
    let educationNumber = educationResult?.firstResult as? ORKNumericQuestionResult
    
    subject.education = (educationNumber?.numericAnswer?.int16Value)!
    
    // Parsing Height Results
    
    let heightResults = taskController.result.stepResult(forStepIdentifier: "heightStep")
    
    var heightString = ""
    var heightUnitString = ""
    
    for result in (heightResults?.results)!{
        
        switch result.identifier {
        
        case "heightUnitItem":
            let unitResult = result as? ORKChoiceQuestionResult
            let unitChoice = unitResult?.choiceAnswers
            if unitChoice!.first! as! Int == 1 {
                heightUnitString = "cm"
            }
            else{
                heightUnitString = "inches"
            }
        default:
            let heightResult = result as? ORKNumericQuestionResult
            let heightNumber = (heightResult?.numericAnswer?.int16Value)!
            heightString = "\(heightNumber)"
        }
        
    }
    
    subject.height = heightString + " " + heightUnitString
    
    // Parsing Weight Results
    
    let weightResults = taskController.result.stepResult(forStepIdentifier: "weightStep")
    
    var weightString = ""
    var weightUnitString = ""
  
    
    for result in (weightResults?.results)!{
        
        switch result.identifier {
            
        case "w8UnitItem":
            let unitResult = result as? ORKChoiceQuestionResult
            let unitChoice = unitResult?.choiceAnswers
            if unitChoice!.first! as! Int == 1 {
                weightUnitString = "lbs"
            }
            else{
                weightUnitString = "kg"
            }
        default:
            let weightResult = result as? ORKNumericQuestionResult
            let weightNumber = (weightResult?.numericAnswer?.int16Value)!
            weightString = "\(weightNumber)"
        }
        
    }
    
    subject.weight = weightString + " " + weightUnitString
    
    PersistenceService.saveContext()
    
}


// Extracts Memory Registration values and assigns them to the subject.

func ExtractMemoryRegistration(taskController: ORKTaskViewController) {
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // there is only one subject
        let subject = subjectArray.first
        
        let regResultOne = taskController.result.stepResult(forStepIdentifier: "trial1RegistrationTextChoiceQuestionStep")
        
        let trialOneChoices = regResultOne?.firstResult as! ORKChoiceQuestionResult
        
        var choiceArray = trialOneChoices.choiceAnswers
        
        let subjectMemory = Memory(context: PersistenceService.context)
        
        subjectMemory.faceRegT1 = false
        subjectMemory.velvetRegT1 = false
        subjectMemory.churchRegT1 = false
        subjectMemory.daisyRegT1 = false
        subjectMemory.redRegT1 = false
        
        for choice in choiceArray! {
        
            let choiceNumber = choice as! NSNumber

            //print("Choice number is : \(choiceNumber)")
            switch choiceNumber.intValue {
            case 0:
                subjectMemory.faceRegT1 = true
            case 1:
                subjectMemory.velvetRegT1 = true
            case 2:
                subjectMemory.churchRegT1 = true
            case 3:
                subjectMemory.daisyRegT1 = true
            default:
                subjectMemory.redRegT1 = true
            }

        }
        
        let regResultTwo = taskController.result.stepResult(forStepIdentifier: "trial2RegistrationTextChoiceQuestionStep")
        
        let trialTwoChoices = regResultTwo?.firstResult as! ORKChoiceQuestionResult
        
        choiceArray = trialTwoChoices.choiceAnswers
        subjectMemory.faceRegT2 = false
        subjectMemory.velvetRegT2 = false
        subjectMemory.churchRegT2 = false
        subjectMemory.daisyRegT2 = false
        subjectMemory.redRegT2 = false
        
        for choice in choiceArray! {
            
            let choiceNumber = choice as! NSNumber
            
            //print("Choice number is : \(choiceNumber)")
            switch choiceNumber.intValue {
            case 0:
                subjectMemory.faceRegT2 = true
            case 1:
                subjectMemory.velvetRegT2 = true
            case 2:
                subjectMemory.churchRegT2 = true
            case 3:
                subjectMemory.daisyRegT2 = true
            default:
                subjectMemory.redRegT2 = true
            }
            
        }
        
        subject?.memory = subjectMemory
        
        PersistenceService.saveContext()
        
    }
    catch {print("Place view Controller that says Alert there is no subject yet")}
    
}

// Memory Scoring Function


func ExtractMemoryScores(taskController: ORKTaskViewController) {
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // there is only one subject.
        let subject = subjectArray.first
        
        subject?.memory?.faceWC = false
        subject?.memory?.velvetWC = false
        subject?.memory?.churchWC = false
        subject?.memory?.daisyWC = false
        subject?.memory?.redWC = false
        subject?.memory?.faceCC = false
        subject?.memory?.velvetCC = false
        subject?.memory?.churchCC = false
        subject?.memory?.daisyCC = false
        subject?.memory?.redCC = false
        subject?.memory?.faceMC = false
        subject?.memory?.velvetMC = false
        subject?.memory?.churchMC = false
        subject?.memory?.daisyMC = false
        subject?.memory?.redMC = false
        
        
        
    }
    catch {print("Place view Controller that says Alert there is no subject yet")}
    
    PersistenceService.saveContext()
    
}
