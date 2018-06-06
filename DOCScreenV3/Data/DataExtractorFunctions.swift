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
        
        // declare all false
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
        
        let trialResults = taskController.result.results
        
        // Helper functions for extracting and recording responses
        // Without Cue extractor
        func ExtractResponesWC(intNumber: Int) {
            
            switch intNumber {
                
            case 0:
                subject?.memory?.faceWC = true
            case 1:
                subject?.memory?.velvetWC = true
            case 2:
                subject?.memory?.churchWC = true
            case 3:
                subject?.memory?.daisyWC = true
            default:
                subject?.memory?.redWC = true
            }
        }
        
        // With Cue Extractor
        func ExtractResponesCC(intNumber: Int) {
            
            switch intNumber {
                
            case 0:
                subject?.memory?.faceCC = true
            case 1:
                subject?.memory?.velvetCC = true
            case 2:
                subject?.memory?.churchCC = true
            case 3:
                subject?.memory?.daisyCC = true
            default:
                subject?.memory?.redCC = true
            }
        }
    
        
        // Multiple Choice Extractor
        
        func ExtractResponesMC(intNumber: Int) {
            
            switch intNumber {
                
            case 0:
                subject?.memory?.faceMC = true
            case 1:
                subject?.memory?.velvetMC = true
            case 2:
                subject?.memory?.churchMC = true
            case 3:
                subject?.memory?.daisyMC = true
            default:
                subject?.memory?.redMC = true
            }
        }
        
        
        switch trialResults?.count {
            
        case 2:
            
            // Parse first and only step, then extract responses without cue.
            let firstQuestionStep = trialResults![1] as! ORKStepResult
            let firstResult = firstQuestionStep.firstResult as! ORKChoiceQuestionResult
            let firstChoiceAnswers = firstResult.choiceAnswers
            for subjectResponse in firstChoiceAnswers! {
                let choiceNumber = subjectResponse as! NSNumber
                ExtractResponesWC(intNumber: choiceNumber.intValue)
            }
            
            // assign a perfect score due to predicateRules
            subject?.memory?.memoryScore = 5
        
        case 3:
        
            // Parse first step, then extract responses without cue.
            let firstQuestionStep = trialResults![1] as! ORKStepResult
            let firstResult = firstQuestionStep.firstResult as! ORKChoiceQuestionResult
            let firstChoiceAnswers = firstResult.choiceAnswers
            for subjectResponse in firstChoiceAnswers! {
                let choiceNumber = subjectResponse as! NSNumber
                ExtractResponesWC(intNumber: choiceNumber.intValue)
            }
            
            // Assign score for memory based only on first test
            subject?.memory?.memoryScore = Int16(firstChoiceAnswers!.count)
            
            // Parse second step, then extracted cued respones
            let secondQuestionStep = trialResults![2] as! ORKStepResult
            let secondResult = secondQuestionStep.firstResult as! ORKChoiceQuestionResult
            let secondChoiceAnswers = secondResult.choiceAnswers
            for subjectResponse in secondChoiceAnswers! {
                let choiceNumber = subjectResponse as! NSNumber
                ExtractResponesCC(intNumber: choiceNumber.intValue)
            }
    
        
        default:
            
            let firstQuestionStep = trialResults![1] as! ORKStepResult
            let firstResult = firstQuestionStep.firstResult as! ORKChoiceQuestionResult
            let firstChoiceAnswers = firstResult.choiceAnswers
            for subjectResponse in firstChoiceAnswers! {
                let choiceNumber = subjectResponse as! NSNumber
                ExtractResponesWC(intNumber: choiceNumber.intValue)
            }
            
            // Assign score for memory based only on first test
            subject?.memory?.memoryScore = Int16(firstChoiceAnswers!.count)

            // Parse second step, then extract cued respones
            let secondQuestionStep = trialResults![2] as! ORKStepResult
            let secondResult = secondQuestionStep.firstResult as! ORKChoiceQuestionResult
            let secondChoiceAnswers = secondResult.choiceAnswers
            for subjectResponse in secondChoiceAnswers! {
                let choiceNumber = subjectResponse as! NSNumber
                ExtractResponesCC(intNumber: choiceNumber.intValue)
            }
            
            // Parse third step, and extract multiple choice responses.
            let thirdQuestionStep = trialResults![3] as! ORKStepResult
            let thirdResult = thirdQuestionStep.firstResult as! ORKChoiceQuestionResult
            let thirdChoiceAnswers = thirdResult.choiceAnswers
            for subjectResponse in thirdChoiceAnswers! {
                let choiceNumber = subjectResponse as! NSNumber
                ExtractResponesMC(intNumber: choiceNumber.intValue)
            }
            
        }
        
    }
        
    catch {print("Place view Controller that says Alert there is no subject yet")}
    
    PersistenceService.saveContext()
    
}

// Mood Extracting function

func ExtractMoodScore(taskController: ORKTaskViewController) {
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // there is only one subject
        let subject = subjectArray.first
        
        // Create Mood object
        let subjectMood = Mood(context: PersistenceService.context)
        
        let q1StepResults = taskController.result.stepResult(forStepIdentifier: "moodChoiceQuestion1Step")
        
        let q1Results = q1StepResults?.firstResult as! ORKChoiceQuestionResult
        
        let q1Score = q1Results.choiceAnswers?.first as! NSNumber
        
        subjectMood.q1Mood = q1Score.int16Value
        
        let q2StepResults = taskController.result.stepResult(forStepIdentifier: "moodChoiceQuestion2Step")
        
        let q2Results = q2StepResults?.firstResult as! ORKChoiceQuestionResult
        
        let q2Score = q2Results.choiceAnswers?.first as! NSNumber
        
        subjectMood.q2Mood = q2Score.int16Value
        
        subjectMood.moodScore = q1Score.int16Value + q2Score.int16Value
        
        // record the mood data and save context
        subject?.mood = subjectMood
        
        PersistenceService.saveContext()
        
    }
    catch {print("Place view Controller that says Alert there is no subject yet")}
    
}

// Abstraction Extracting function

func ExtractAbstractionScore(taskController: ORKTaskViewController){
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // there is only one subject
        let subject = subjectArray.first
        
        let subjectAbstraction = Abstraction(context: PersistenceService.context)
        
        let transportResults = taskController.result.stepResult(forStepIdentifier: "transportStep")?.firstResult as! ORKBooleanQuestionResult
        
        let transportBool = transportResults.booleanAnswer?.boolValue
        
        subjectAbstraction.q1BoolScore = transportBool!
        
        let measureResults = taskController.result.stepResult(forStepIdentifier: "measureStep")?.firstResult as! ORKBooleanQuestionResult
        
        let measureBool = measureResults.booleanAnswer?.boolValue
        
        subjectAbstraction.q2BoolScore = measureBool!
        
        subjectAbstraction.abstractScore = NSNumber(booleanLiteral: transportBool!).int16Value + NSNumber(booleanLiteral: measureBool!).int16Value
        
        subject?.abstract = subjectAbstraction
        
        PersistenceService.saveContext()
    }
    catch {print("Place view Controller that says Alert there is no subject yet")}
    
}

// Apnea Extract

func ExtractApneaScore(taskController: ORKTaskViewController) {
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // there is only one subject
        let subject = subjectArray.first
        
        let subjectApnea = Apnea(context: PersistenceService.context)
        
        let taskResults = taskController.result.results
        
        var apneaArray = [Bool]();
        
        for taskResult in taskResults![1...4] {
            
            let stepResult = taskResult as! ORKStepResult
            
            let boolQuestionResult = stepResult.firstResult as! ORKBooleanQuestionResult
            
            apneaArray.append((boolQuestionResult.booleanAnswer?.boolValue)!)
            
        }
        
        subjectApnea.q1Score = apneaArray[0]
        subjectApnea.q2Score = apneaArray[1]
        subjectApnea.q3Score = apneaArray[2]
        subjectApnea.q4Score = apneaArray[3]
        subjectApnea.apneaScore = apneaArray.map{ NSNumber(value: $0).int16Value}.reduce(0, +)
        
        subject?.apnea = subjectApnea
        
        PersistenceService.saveContext()
    }
    catch {print("Place view Controller that says Alert there is no subject yet")}
    
}
