//
//  DataExtractorFunctions.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-05-23.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit


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
