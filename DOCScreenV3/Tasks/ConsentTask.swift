//
//  ConsentTask.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-08-13.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import ResearchKit



public var ConsentTask: ORKOrderedTask {

    var steps = [ORKStep]()
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = NSLocalizedString("DOC Screen Consent Form", comment: "")
    
    let section1 = ORKConsentSection(type: .overview)
    section1.summary = NSLocalizedString("DOC Screen is a  single, integrated, evidence-based tool to facilitate efficient identification of patients at very high risk, and those at very low risk, for all three complex outcomes", comment: "")
    section1.content = NSLocalizedString("DOC Screen is a  single, integrated, evidence-based tool to facilitate efficient identification of patients at very high risk, and those at very low risk, for all three complex outcomes. We have screened more than 1500 patients, and compared screening results to detailed testing used by specialists to diagnose these conditions in 439 volunteers. We have shown that the screen is both feasible and valid: 89% of patients can be screened in 5 minutes or less. Depression, sleep problems and cognitive impairment are not necessarily yes/no problems. Thus, screening tests cannot be used as a diagnosis. Rather, the results of this screen can be used to identify people as high-, intermediate- or low-risk for each DOC condition. No screen should be used as diagnostic test or as a substitute for clinical judgement. For example, a score of 5 or less on DOC-cognition reflects a high risk of cognitive impairment, but does not assess whether there is a decline from a previous level of functioning, nor to impact on activities of daily living. ", comment: "")
    
    
    let section2 = ORKConsentSection(type: .dataGathering)
    section2.summary = NSLocalizedString("All of the personal health information collected on this device/application will be used to improve the secondary prevention care of patients.", comment: "")
    section2.content = NSLocalizedString("All of the personal health information collected on this device/application will be used to improve the secondary prevention care of patients. This screening application collects patients’ names, age, sex, height/weight, and education levels.", comment: "")
    
    let section3 = ORKConsentSection(type: .privacy)
    section3.summary = NSLocalizedString("Absolutely no personal health information will be stored on either this device or application, in order to maintain the privacy and confidentiality of each patient assessed using this device/application.", comment: "")
    section3.content = NSLocalizedString("Absolutely no personal health information will be stored on either this device or application, in order to maintain the privacy and confidentiality of each patient assessed using this device/application. De-identified results to this screening assessment will automatically be sent to the DOC Project team and used for the purposes of improving the functionality and accuracy of the application. These include pictures of clock drawings", comment: "")
    
    let section4 = ORKConsentSection(type: .dataUse)
    section4.summary = NSLocalizedString("If health care practitioners wish to store the results of this screening assessment by e-mail, they must input a trusted e-mail address at the end of the screen where the results can be sent." , comment: "")
    section4.content = NSLocalizedString("If health care practitioners wish to store the results of this screening assessment by e-mail, they must input a trusted e-mail address at the end of the screen where the results can be sent." , comment: "")
   
    
    let section5 = ORKConsentSection(type: .custom)
    section5.title = "Responsibility"
    section5.content = NSLocalizedString("The developers of this application absolve responsibility of breaches in privacy and confidentiality once results have been sent from the device by method of the user’s choice." , comment: "")
    section5.summary = NSLocalizedString("The developers of this application absolve responsibility of breaches in privacy and confidentiality once results have been sent from the device by method of the user’s choice." , comment: "")
    
    
    let section6 = ORKConsentSection(type: .custom)
    section6.title = "Agreement"
    section6.content = NSLocalizedString(" - I agree that only health care professionals will have access to the device hosting this application, and that only health care professionals will be allowed to collect personal health information with this application. \n\n - I agree to use a secure, institutional e-mail address when sending the results of this screening assessment, in order to minimize the risk of privacy breaches pertaining to patients’ personal health information. \n\n - I accept responsibility for the transference, storage, and maintenance of any personal health information collected on this application, after it is e-mailed to my (the user) address of choice. \n\n - I agree to have de-identified results of the assessments completed sent to the DOC Project Team, led by Dr. Richard Swartz, in order to improve the functionality and accuracy of this application", comment: "")
    
    section6.summary = NSLocalizedString("I agree to the following: \n\n - Only health care professionals will have access to the device hosting this application \n\n -  The use of a secure, institutional e-mail address when sending the results. \n\n - Acceptence of responsibility for the transference, storage, and maintenance of any personal health information collected on this application. \n \n - Have de-identified results of the assessments completed sent to the DOC Project Team, led by Dr. Richard Swartz" , comment: "")
    
    consentDocument.sections = [section1, section2, section3,section4,section5, section6]
    
    let consentStep = ORKVisualConsentStep(
        identifier: "VisualConsentStep",
        document: consentDocument)
    
    steps += [consentStep]
    
    let reviewConsentStep = ORKConsentReviewStep(
        identifier: "ConsentReviewStep",
        signature: nil,
        in: consentDocument)
    
    steps += [reviewConsentStep]
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}

