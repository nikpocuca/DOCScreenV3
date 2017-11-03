//
//  TaskTableViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-02.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit
import ResearchKit

class TaskTableViewController: UITableViewController {

    
    
    var docEntries = [DocEntry]()
    
    
    
    private func loadTasks() {
        
        guard let task1 = DocEntry(TaskName: "Profile", Image: #imageLiteral(resourceName: "profile"), CompleteString: "", Task: ProfileTask)
            else { fatalError("unable to create docEntry") }
        
        guard let task2 = DocEntry(TaskName: "Registration", Image: #imageLiteral(resourceName: "memory"), CompleteString: "", Task: MemoryRegistrationTask)
            else { fatalError("unable to create docEntry") }

        guard let task3 = DocEntry(TaskName: "Mood", Image: #imageLiteral(resourceName: "mood"), CompleteString: "", Task: MoodTask)
            else { fatalError("unable to create docEntry") }

        guard let task4 = DocEntry(TaskName: "Sleep", Image: #imageLiteral(resourceName: "sleep"), CompleteString: "", Task: SleepTask)
            else { fatalError("unable to create docEntry") }

        guard let task5 = DocEntry(TaskName: "Clock", Image: #imageLiteral(resourceName: "clock"), CompleteString: "", Task: ClockTask)
            else { fatalError("unable to create docEntry") }

        guard let task6 = DocEntry(TaskName: "Abstraction", Image: #imageLiteral(resourceName: "abstraction"), CompleteString: "", Task: AbstractionTask)
             else { fatalError("unable to create docEntry") }
        
        guard let task7 = DocEntry(TaskName: "Memory", Image: #imageLiteral(resourceName: "memory"), CompleteString: "", Task: MemoryTask)
            else { fatalError("unable to create docEntry") }
        
        
        docEntries = [task1,task2,task3,task4,task5,task6,task7];
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        DataStorage.date = formatter.string(from: Date())
        
        loadTasks()
       
        UIView.appearance().tintColor = UIColor.docRed()

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return docEntries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TaskTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TaskTableViewCell.")
        }
        
        let task = docEntries[indexPath.row]
        
        
        cell.taskNameOut.text = task.taskName
        cell.taskImageOut.image = task.image
        
        
        let selectBackground = UIView()
        
        selectBackground.backgroundColor = UIColor.init(red: 237/255, green: 34/255, blue: 38/255, alpha: 1)
        
        cell.selectedBackgroundView = selectBackground
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This is what its going to select.
        
  
        let currentCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
    
    
        currentCell.taskNameOut.textColor = UIColor.white

        let runTask = docEntries[indexPath.row].taskIdentifier
        
        let taskViewController = ORKTaskViewController(task: runTask, taskRun: nil)
            
            taskViewController.delegate = self
        
        
        taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        present(taskViewController, animated: true, completion: nil)
        
      
      tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        currentCell.taskNameOut.textColor = UIColor.red
        
     }
    
    


}

extension TaskTableViewController:  ORKTaskViewControllerDelegate{
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
  
        taskViewController.dismiss(animated: true, completion: nil)
        
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        
        func loadImage(fileName: String) -> UIImage? {
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
            return nil
        }

        
        
        func crop(image: UIImage, withWidth width: Double, andHeight height: Double) -> UIImage? {
            
            if let cgImage = image.cgImage {
                
                let contextImage: UIImage = UIImage(cgImage: cgImage)
                
                let contextSize: CGSize = contextImage.size
                
                var posX: CGFloat = 0.0
                var posY: CGFloat = 0.0
                var cgwidth: CGFloat = CGFloat(width)
                var cgheight: CGFloat = CGFloat(height)
                
                // See what size is longer and create the center off of that
                if contextSize.width > contextSize.height {
                    posX = ((contextSize.width - contextSize.height) / 2)
                    posY = 0
                    cgwidth = contextSize.height
                    cgheight = contextSize.height
                } else {
                    posX = 0
                    posY = ((contextSize.height - contextSize.width) / 2)
                    cgwidth = contextSize.width
                    cgheight = contextSize.width
                }
                
                let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
                
                // Create bitmap image from context using the rect
                var croppedContextImage: CGImage? = nil
                if let contextImage = contextImage.cgImage {
                    if let croppedImage = contextImage.cropping(to: rect) {
                        croppedContextImage = croppedImage
                    }
                }
                
                // Create a new image based on the imageRef and rotate back to the original orientation
                if let croppedImage:CGImage = croppedContextImage {
                    let image: UIImage = UIImage(cgImage: croppedImage, scale: image.scale, orientation: image.imageOrientation)
                    return image
                }
                
            }
            
            return nil
        }
        
/*
        let lexicon = ["sex": DataStorage.sex,
                       "name": DataStorage.name,
                       "age": DataStorage.age,
                       "BMI": DataStorage.BMI,
                       "weight": DataStorage.weight,
                       "education": DataStorage.education
            ] as NSMutableDictionary
        */
        
        
        let textAnswerSteps: Array<String> = ["nameStep"]
        let numericAnswerSteps:  Array<String> = ["ageStep","educationStep"]
        let booleanAnswerSteps: Array<String> = ["sexStep","transportStep","measureStep","loudQuestion","fatigueQuestion","breathQuestion","bloodQuestion"]
        let choiceAnswerSteps: Array<String> = ["trialWithoutCueStep"]
        let moodChoiceAnswerSteps: Array<String> = ["moodChoiceQuestion1Step","moodChoiceQuestion2Step"]
        let formAnswerSteps: Array<String> = ["heightStep","weightStep"]
        var data = [String: String]()
        
        for step in formAnswerSteps {
            if reason == .completed {
             if let stepResult = taskViewController.result.stepResult(forStepIdentifier: step),
                let stepResults = stepResult.results {
                    print(stepResults)
                for formItem in stepResults {
                    if formItem.identifier == "heightAnswerItem" {
                        
                        let heightAnswerItem = formItem as? ORKNumericQuestionResult
                        let numericAnswer = heightAnswerItem!.numericAnswer
                        if numericAnswer != nil{
                        let input = "\(numericAnswer!)"
                        print(input)
                        data[step] = input;
                        }
                            }
                    
                    if formItem.identifier == "weightAnswerItem" {
                        
                        let weightAnswerItem = formItem as? ORKNumericQuestionResult
                        let numericAnswer = weightAnswerItem!.numericAnswer
                        if numericAnswer != nil {
                        let input = "\(numericAnswer!)"
                        print(input)
                        data[step] = input;
                        }
                    }
        
                        }
                    //data = [step: input]
                }
            }
        }
        
        
        
        
        
        
        for step in textAnswerSteps {
            if reason == .completed {
            if let stepResult = taskViewController.result.stepResult(forStepIdentifier: step),
                let stepResults = stepResult.results,
                let stepFirstResult = stepResults.first,
                let textResult = stepFirstResult as? ORKTextQuestionResult,
                let textAnswer = textResult.textAnswer {
                let input =  "\(textAnswer)"
                data = [step: input]
                }
            }
        }
        
        for step in numericAnswerSteps {
              if reason == .completed {
            if let stepResult = taskViewController.result.stepResult(forStepIdentifier: step),
            let stepResults = stepResult.results,
            let stepFirstResult = stepResults.first,
            let numericResult = stepFirstResult as? ORKNumericQuestionResult,
            let numericAnswer = numericResult.numericAnswer {
            let input = "\(numericAnswer)"
                data[step] = input;
                }
            }
        }
    
        for step in booleanAnswerSteps {
            if reason == .completed {
                if let stepResult = taskViewController.result.stepResult(forStepIdentifier: step),
                    let stepResults = stepResult.results,
                    let stepFirstResult = stepResults.first,
                    let booleanResult = stepFirstResult as? ORKBooleanQuestionResult,
                    let boolAnswer = booleanResult.booleanAnswer {
                    let input = "\(boolAnswer)"
                    data[step] = input;
                }
            }
        }
        
        for step in choiceAnswerSteps {
            if reason == .completed {
                if let stepResult = taskViewController.result.stepResult(forStepIdentifier: step),
                    let stepResults = stepResult.results,
                    let stepFirstResult = stepResults.first,
                    let choiceResult = stepFirstResult as? ORKChoiceQuestionResult,
                    let choiceAnswer = choiceResult.choiceAnswers {
                    let input = "\(choiceAnswer)"
                    data[step] = input;
                }
            }
        }
        
        for step in moodChoiceAnswerSteps {
            if reason == .completed {
                if let stepResult = taskViewController.result.stepResult(forStepIdentifier: step),
                    let stepResults = stepResult.results,
                    let stepFirstResult = stepResults.first,
                    let choiceResult = stepFirstResult as? ORKChoiceQuestionResult,
                    let choiceAnswer = choiceResult.choiceAnswers {
                    let input = "\(choiceAnswer)"
                    data[step] = input;
                }
            }
        }
        
        let preLexKeys = data.keys
        let lexKeys = Array(preLexKeys)
        
        print(data)
        
        
        if taskViewController.task?.identifier == "MoodTask"{
            DataStorage.moodScore = 0;
        }
        if taskViewController.task?.identifier == "SleepTask"{
            DataStorage.apneaScore = 0;
        }
        
        if taskViewController.task?.identifier == "MemoryTask"{
            DataStorage.memoryScore = 0;
        }
        
        if taskViewController.task?.identifier == "AbstractionTask"{
            DataStorage.abstractScore = 0;
        }
        
        if taskViewController.task?.identifier == "ClockTask" {
            
            let result = taskViewController.result
            
            if result.stepResult(forStepIdentifier: "imageStep") != nil {
                
                let loadSaved = loadImage(fileName: "imageStep.jpg")!
                
                let postCrop = crop(image: loadSaved, withWidth: 2000, andHeight: 2000)!
                
                DataStorage.clockImage = postCrop
                
            }
            
            
            let model = MobileNet()
            
            
            let inputImage = ImageProcessor.resizeImage(image: DataStorage.clockImage, targetSize: CGSize.init(width: 224, height: 224))
            
            DataStorage.clockImage = inputImage
            
            
            if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: inputImage.cgImage!) {
                guard let scene = try? model.prediction(data: pixelBuffer) else {fatalError("Image Error")}
                
        
            ClockData.contour = 0;
            ClockData.numbers = 0;
            ClockData.hands = 0;
                
                if scene.classLabel.contains("clock"){
                    
                    ClockData.numbers = 1;
                }
                
                
                
            }
            DataStorage.clockScore = ClockData.contour + ClockData.hands + ClockData.numbers
            
        }
        
        
        
        for preKey in lexKeys {
        
        let postKeyComponents = preKey.components(separatedBy: "Step")
        let postKey = postKeyComponents[0]
        
            // Handle Sleep Scoring
            if taskViewController.task?.identifier == "SleepTask"{
            
                let booleanChoice = data[preKey];
                
                let questionScore = Int(booleanChoice!)!
                
                DataStorage.apneaScore += questionScore
                
            }
            
            // Handle Memory Scoring
            
            if taskViewController.task?.identifier == "MemoryTask" {
                
                let textChoice = data[preKey]!;
                
                let resultsArray = Array(textChoice.removeCharacters(from: "[], "));
                print("\(resultsArray)")
                
                let memoryScore = resultsArray.count
                
                DataStorage.memoryScore = memoryScore;
                
            }
            
            
            // Handle Abstraction Scoring.
            
            if taskViewController.task?.identifier == "AbstractionTask" {
                
                let booleanChoice = data[preKey]!
                
                let questionScore = Int(booleanChoice)!
                
                DataStorage.abstractScore += questionScore
                
            }
            
            
            
            // Handle Mood Scoring
            if moodChoiceAnswerSteps.contains(preKey) {
                
                let moodChoice = data[preKey];
                
                let moodScore = Int((moodChoice?.removeCharacters(from: "[]"))!)
                
                DataStorage.moodScore += moodScore! }
            
            
            
            // Handle BMI Calculation
            if taskViewController.task?.identifier == "ProfileTask" {
            
                func str2Float(num: String) -> CGFloat {
                let numberFormatter = NumberFormatter()
                let number = numberFormatter.number(from: num)!
                let numberFloatValue = number.floatValue
                    
                    return CGFloat(numberFloatValue)
                }
                
                
                let weight = str2Float(num: data["weightStep"]!)
                let height = str2Float(num: data["heightStep"]!)
                
                let denom = height*height
                
                let BMI = CGFloat(weight)/CGFloat(denom)
                
                let input = "\(BMI)"
                
                
                print("denom is: \(input)")

                
               
            
                
                
                dataPass(name: "BMI", value: input )
                
                }
            //end call to fill in data.
            dataPass(name: postKey, value: data[preKey]!)

        }
        

        
        
        
       
    }
    
    
}
