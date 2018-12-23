//
//  DOCCompilerFunctions.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-06-10.
//  Copyright © 2018 Nik. All rights reserved.
//

import Foundation
import UIKit
import PDFGenerator
import CoreData


func createLabel(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String) -> UILabel {
    let newUILabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height));
    newUILabel.text = text;
    return newUILabel
}


func CreatePDF() {
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // there is only one subject
        let subject = subjectArray.first
        
        
        let formView = UIView(frame: CGRect(x: 0, y: 0, width: 1275, height: 1650))
        formView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "DOCForm.png"))
        
        let check = "✓"
        
        
        // Helper functions for Pdf Compilition
        func booleanToCheck(inputBool: Bool) -> String {
            switch inputBool {
            case true:
                return(check)
            default:
                return("")
            }
        }
        
        func int16ToString(inputInt: Int16) -> String {
            return(String(inputInt))
        }
        
        func sexToString(inputBool: Bool) -> String{
            switch inputBool {
            case true:
                return("Male")
            default:
                return("Female")
            }
        }
        
        // BMI Calculation + units
        
        func bmiToString(inputHeight: String, inputWeight: String) -> String {
            
            let heightStrings = inputHeight.split(separator: " ");
            let heightNumString = heightStrings[0];
            var heightUnitString = heightStrings[1];
            let height = NSNumber(value: Float(heightNumString)!)
            
            let weightStrings = inputWeight.split(separator: " ");
            let weightNumString = weightStrings[0];
            let weightUnitString = weightStrings[1];
            let weight = NSNumber(value: Float(weightNumString)!)
            
            var bmiFloat = weight.floatValue/(height.floatValue*height.floatValue)
            
            if heightUnitString == "cm" {bmiFloat = bmiFloat*10000
               heightUnitString = "m"
            }
            
            else {}
            
            let bmiNumString = String(bmiFloat)
            
            let bmiUnitString = weightUnitString + "/" + heightUnitString + "^2";
            
            let bmiString = bmiNumString + " " + bmiUnitString
            return (bmiString);
        }

        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let nameLabel = createLabel(x: 415, y: 144, width: 200, height: 21, text: (subject?.name!)!)
        let dateLabel = createLabel(x: 882, y: 144, width: 295, height: 21, text: (subject?.date)!)
        let ageLabel = createLabel(x: 400, y: 219, width: 100, height: 21, text: int16ToString(inputInt: (subject?.age)!))
        let sexLabel = createLabel(x: 697, y: 219, width: 115, height: 21, text: sexToString(inputBool: (subject?.sex)!))
        let eduLabel = createLabel(x: 1070, y: 219, width: 63, height: 21, text: int16ToString(inputInt: (subject?.education)!))
        let heightLabel = createLabel(x: 415, y: 257, width: 100, height: 21, text: (subject?.height)!)
        let weightLabel = createLabel(x: 723, y: 257, width: 100, height: 21, text: (subject?.weight)!)
        let bmLabel = createLabel(x: 999, y: 256, width: 150, height: 21, text: bmiToString(inputHeight: (subject?.height)!, inputWeight: (subject?.weight)!))
        let f1Label = createLabel(x: 642, y: 322, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.faceRegT1)!))
        let f2Label = createLabel(x: 642, y: 355, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.faceRegT2)!))
        let v1Label = createLabel(x: 744, y: 322, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.velvetRegT1)!))
        let v2Label = createLabel(x: 744, y: 355, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.velvetRegT2)!))
        let c1Label = createLabel(x: 865, y: 322, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.churchRegT1)!))
        let c2Label = createLabel(x: 865, y: 355, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.churchRegT2)!))
        let d1Label = createLabel(x: 956, y: 322, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.daisyRegT1)!))
        let d2Label = createLabel(x: 956, y: 355, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.daisyRegT1)!))
        let r1Label = createLabel(x: 1052, y: 322, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.redRegT1)!))
        let r2Label = createLabel(x: 1052, y: 359, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.daisyRegT2)!))
        
        // define mood return functions, creates labels on the row and column associated with the result
        
        func moodReturnLabelsFirstRow(input: Int16) -> UILabel {
            switch input {
            case Int16(0):
                return(createLabel(x: 564, y: 467, width: 63, height: 21, text: check))
            case Int16(1):
                return(createLabel(x: 740, y: 467, width: 63, height: 21, text: check))
            case Int16(2):
                return(createLabel(x: 890, y: 467, width: 63, height: 21, text: check))
            default:
                return(createLabel(x: 1033, y: 467, width: 63, height: 21, text: check))
            }
        }
        
        func moodReturnLabelsSecondRow(input: Int16) ->  UILabel {
            switch input {
            case Int16(0):
                return(createLabel(x: 564, y: 504, width: 63, height: 21, text: check))
            case Int16(1):
                return(createLabel(x: 740, y: 504, width: 63, height: 21, text: check))
            case Int16(2):
                return(createLabel(x: 890, y: 504, width: 63, height: 21, text: check))
            default:
                return(createLabel(x: 1033, y: 504, width: 63, height: 21, text: check))
            }
        }
        
        let mR1Label = moodReturnLabelsFirstRow(input: (subject?.mood?.q1Mood)!)
        let mR2Label = moodReturnLabelsSecondRow(input: (subject?.mood?.q2Mood)!)
        
        let moodScoreLabel = createLabel(x: 1150, y: 479, width: 63, height: 21, text: int16ToString(inputInt: (subject?.mood?.moodScore)!))
        
        // define apnea return functions for UIlabels.
        
        func apneaQOneLabel(inputBool: Bool) -> UILabel {
            switch inputBool {
            case false:
                return(createLabel(x: 1045, y: 574, width: 63, height: 21, text: check))
            default:
                return(createLabel(x: 932, y: 574, width: 63, height: 21, text: check))
            }
        }
        
        func apneaQTwoLabel(inputBool: Bool) -> UILabel {
            switch inputBool {
            case false:
                return(createLabel(x: 1045, y: 606, width: 63, height: 21, text: check))
            default:
                return(createLabel(x: 932, y: 606, width: 63, height: 21, text: check))
            }
        }
        
        func apneaQThreeLabel(inputBool: Bool) -> UILabel {
            switch inputBool {
            case false:
                return(createLabel(x: 1045, y: 639, width: 63, height: 21, text: check))
            default:
                return(createLabel(x: 932, y: 639, width: 63, height: 21, text: check))
            }
        }
        
        func apneaQFourLabel(inputBool: Bool) -> UILabel {
            switch inputBool {
            case false:
                return(createLabel(x: 1045, y: 669, width: 63, height: 21, text: check))
            default:
                return(createLabel(x: 932, y: 669, width: 63, height: 21, text: check))
            }
        }
        
        let q1ApneaLabel = apneaQOneLabel(inputBool: (subject?.apnea?.q1Score)!)
        let q2ApneaLabel = apneaQTwoLabel(inputBool: (subject?.apnea?.q2Score)!)
        let q3ApneaLabel = apneaQThreeLabel(inputBool: (subject?.apnea?.q3Score)!)
        let q4ApneaLabel = apneaQFourLabel(inputBool: (subject?.apnea?.q4Score)!)
        
        let apneaScoreLabel = createLabel(x: 1144, y: 632, width: 63, height: 21, text: int16ToString(inputInt: (subject?.apnea?.apneaScore)!))
        
        let af1Label = createLabel(x: 637, y: 1196, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.faceWC)!))
        let af2Label = createLabel(x: 637, y: 1230, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.faceCC)!))
        let af3Label = createLabel(x: 637, y: 1263, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.faceMC)!))
        let av1Label = createLabel(x: 733, y: 1196, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.velvetWC)!))
        let av2Label = createLabel(x: 733, y: 1230, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.velvetCC)!))
        let av3Label = createLabel(x: 733, y: 1263, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.velvetMC)!))
        let ac1Label = createLabel(x: 843, y: 1196, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.churchWC)!))
        let ac2Label = createLabel(x: 843, y: 1230, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.churchCC)!))
        let ac3Label = createLabel(x: 843, y: 1263, width: 63, height: 21, text: booleanToCheck(inputBool:(subject?.memory?.churchMC)!))
        let ad1Label = createLabel(x: 949, y: 1196, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.daisyWC)!))
        let ad2Label = createLabel(x: 949, y: 1230, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.daisyCC)!))
        let ad3Label = createLabel(x: 949, y: 1263, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.daisyMC)!))
        let ar1Label = createLabel(x: 1054, y: 1196, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.redWC)!))
        let ar2Label = createLabel(x: 1054, y: 1230, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.redCC)!))
        let ar3Label = createLabel(x: 1054, y: 1263, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.memory?.redMC)!))
        let memoryScoreLabel = createLabel(x: 1145, y: 1239, width: 63, height: 21, text: int16ToString(inputInt: (subject?.memory?.memoryScore)!))
        
        let tallyMoodScoreLabel = createLabel(x: 1143, y: 1370, width: 63, height: 21, text: int16ToString(inputInt: (subject?.mood?.moodScore)!))
        let tallyApneaScoreLabel = createLabel(x: 1143, y: 1409, width: 63, height: 21, text: int16ToString(inputInt: (subject?.apnea?.apneaScore)!))
        let tallyCogScoreLabel = createLabel(x: 1135, y: 1450, width: 63, height: 21, text: int16ToString(inputInt: (subject?.clock?.clockScore)! + (subject?.abstract?.abstractScore)! + (subject?.memory?.memoryScore)!))
        
        let contourLabel = createLabel(x: 1051, y: 845, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.clock?.contour)!))
        let numbersLabel = createLabel(x: 1051, y: 891, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.clock?.numbers)!))
        let handsLabel = createLabel(x: 1051, y: 937, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.clock?.hands)!))
        let clockScoreLabel =  createLabel(x: 1145, y: 919, width: 63, height: 21, text: int16ToString(inputInt: (subject?.clock?.clockScore)!))
        let ab1Label = createLabel(x: 312, y: 1123, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.abstract?.q1BoolScore)!))
        let ab2Label = createLabel(x: 840, y: 1123, width: 63, height: 21, text: booleanToCheck(inputBool: (subject?.abstract?.q2BoolScore)!))
        let absScore = createLabel(x: 1140, y: 1123, width: 63, height: 21, text: int16ToString(inputInt: (subject?.abstract?.abstractScore)!) )
        
        // data string on pdf.
        
     
        
        func generateDataString() -> String {
            let profileString = "name: \((subject?.name)!), age: \((subject?.age)!), date: \((subject?.date)!),edu: \((subject?.education)!),height: \((subject?.height)!), weight: \((subject?.weight)!),sex: \(sexToString(inputBool: (subject?.sex)!))"
            return(profileString)
        }
        
        let dataStringLabel = createLabel(x: 42, y: 1538, width: 917, height: 21, text: generateDataString())
        
        dataStringLabel.font = dataStringLabel.font.withSize(1)
        
        let clockImageView = UIImageView(frame: CGRect(x: 272, y: 735, width: 325, height: 325))
        
        let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("clockScan.png")
        
        let imageData =  try Data(contentsOf: imageURL)
        
        clockImageView.image = UIImage(data: imageData)
        
        let formLabels: [UILabel] = [nameLabel,dateLabel,ageLabel,sexLabel,eduLabel,heightLabel,weightLabel,bmLabel,
                                     contourLabel,numbersLabel,handsLabel,clockScoreLabel,ab1Label,ab2Label,
                                     af1Label,af2Label,af3Label,av1Label,av2Label,av3Label,ac1Label,ac2Label,ac3Label,ad1Label,ad2Label,ad3Label,ar1Label, absScore,
                                         mR1Label,mR2Label,
                                     ar2Label,ar3Label,memoryScoreLabel,tallyMoodScoreLabel,tallyApneaScoreLabel,tallyCogScoreLabel,f1Label,f2Label,v1Label,
                                     v2Label,c1Label,c2Label,d1Label,d2Label,r1Label,r2Label,dataStringLabel,
                                     
                                     moodScoreLabel,q1ApneaLabel,q2ApneaLabel,q3ApneaLabel,q4ApneaLabel,apneaScoreLabel]
        for label in formLabels { formView.addSubview(label) }
        
        formView.addSubview(clockImageView)
        
        do {
            let page: [PDFPage] = [PDFPage.view(formView)
                
            ]
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "ddMMYYYY_HH"
            let prefix_name = formatter.string(from: date)
            InfoPdf.name_pdf = prefix_name
            
            let path = NSTemporaryDirectory().appending(prefix_name).appending(".pdf")
            print(path);
            try PDFGenerator.generate(page, to: path)
        } catch let error {
            print(error)
        }
        
    }
    catch {print(error)}
    
    
}
