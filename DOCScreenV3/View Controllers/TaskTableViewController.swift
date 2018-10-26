//
//  TaskTableViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-02.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit
import ResearchKit
import CoreML
import CoreData


class TaskTableViewController: UITableViewController {

    @IBOutlet weak var reviewBarItem: UIBarButtonItem!
    
    @IBAction func reviewAction(_ sender: Any) {
        
        // query core data.
        
        let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
        
        do {
            let controlArray = try PersistenceService.context.fetch(fetchRequest)
            let control = controlArray.first
            
            if control?.fullComplete == true {
                
                CreatePDF()
                
                
                let path = NSTemporaryDirectory().appending(InfoPdf.name_pdf).appending(".pdf")
                
                let documentInteractionController = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
                documentInteractionController.delegate = self
                documentInteractionController.presentPreview(animated: true)
                
            }
            
            else {
               present(callErrorAlert(title: "Error", msg: "DOC Screen not completed, please finish every section"),animated: true,completion: nil)
            }
            
        } catch {
                print("hit control failure")
                present(callError(), animated: true, completion: nil)}
        
    }
        
        
    
    
    
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
        // When selected for current cell, launch the task
  
        let currentCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
    
        currentCell.taskNameOut.textColor = UIColor.white

        let runTask = docEntries[indexPath.row].taskIdentifier
        
        let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
        
        do {
            
            let controlArray = try PersistenceService.context.fetch(fetchRequest)
            
            var control = controlArray.first
            
            if (control != nil && control?.profileComplete != false) {
            
            if (runTask.identifier == "ProfileTask" && (control?.profileComplete)!) {
                
                let refreshAlert = UIAlertController(title: "Caution Overwrite", message: "Starting a new subject deletes all task data, are you sure you want to over-write?", preferredStyle: UIAlertControllerStyle.alert)
                
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
       
                    // once the OK is hit you can run the profile view controller, but it jsut gets hung.
                    let taskViewController = ORKTaskViewController(task: runTask, taskRun: nil)
                    
                    taskViewController.delegate = self
                    
                    
                    taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    self.present(taskViewController, animated: true, completion: nil)
                    
                    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
                    
                    currentCell.taskNameOut.textColor = UIColor.red
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in

                    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
                    
                    currentCell.taskNameOut.textColor = UIColor.red

                    // Takes back to list.
                }))
                
                // Present the alert above ^
                present(refreshAlert, animated: true, completion: nil) }
                
                
            else {
                
                let taskViewController = ORKTaskViewController(task: runTask, taskRun: nil)
                
                taskViewController.delegate = self
                
                
                taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                present(taskViewController, animated: true, completion: nil)
                
                tableView.deselectRow(at: indexPath as IndexPath, animated: true)
                
                currentCell.taskNameOut.textColor = UIColor.red
                }
        }
        
        else {
                
                if (runTask.identifier == "ProfileTask") {
                    
                    let taskViewController = ORKTaskViewController(task: runTask, taskRun: nil)
                    
                    taskViewController.delegate = self
                    
                    
                    taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    present(taskViewController, animated: true, completion: nil)
                    
                    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
                    
                    currentCell.taskNameOut.textColor = UIColor.red
                    
                }
                
                    
                else {
                present(callErrorAlert(title: "No Subject", msg: "Error you must start a subject first."), animated: true, completion: nil)
                
                tableView.deselectRow(at: indexPath as IndexPath, animated: true)
                
                currentCell.taskNameOut.textColor = UIColor.red
                }
            }
            
            
            } catch { present(callError(), animated: true, completion: nil)}
     }
    

}

extension TaskTableViewController:  ORKTaskViewControllerDelegate, UIDocumentInteractionControllerDelegate{
    
    //MARK: UIDocumentInteractionController delegates
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
  
        taskViewController.dismiss(animated: true, completion: nil)

        
        // Handle ControlSettings ahead of time.
        
        let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
        
        do {
            
            let controlArray = try PersistenceService.context.fetch(fetchRequest)
            
            var control = controlArray.first
            
            if (control == nil ){
                control = ControlSettings(context: PersistenceService.context)
                control?.abstractionComplete = false
                control?.apneaComplete = false
                control?.clockComplete = false
                control?.fullComplete = false
                control?.memoryComplete = false
                control?.moodComplete = false
                control?.profileComplete = false
                control?.consentComplete = false 
            }
        
            if taskViewController.task?.identifier == "ProfileTask" {
                if reason == .completed {
                    
                    ExtractProfile(taskController: taskViewController)
                    
                    control?.profileComplete = true
                    
                    control?.abstractionComplete = false
                    control?.apneaComplete = false
                    control?.clockComplete = false
                    control?.fullComplete = false
                    control?.memoryComplete = false
                    control?.moodComplete = false
                    
                    PersistenceService.saveContext()
                }
            }
        
            if taskViewController.task?.identifier == "MemoryRegistrationTask"{
                if reason == .completed {
                 
                    ExtractMemoryRegistration(taskController: taskViewController)
                    
                }
            }
        
            if taskViewController.task?.identifier == "MemoryTask"{
                if reason == .completed {
                    
                    ExtractMemoryScores(taskController: taskViewController)
                    
                    control?.memoryComplete = true
                    
                    PersistenceService.saveContext()
                }
                
            }
        
            if taskViewController.task?.identifier == "MoodTask"{
                if reason == .completed {
                    
                    ExtractMoodScore(taskController: taskViewController)
                    
                    control?.moodComplete = true
                    
                    PersistenceService.saveContext()
                }
                
            }
        
            if taskViewController.task?.identifier == "AbstractionTask"{
                if reason == .completed {
                    
                    ExtractAbstractionScore(taskController: taskViewController)
                    
                    control?.abstractionComplete = true
                    
                    PersistenceService.saveContext()
                    
                }
                
            }
        
            if taskViewController.task?.identifier == "SleepTask"{
                if reason == .completed {
                    
                    ExtractApneaScore(taskController: taskViewController)
                    
                    control?.apneaComplete = true
                    
                    PersistenceService.saveContext()
                }
                
            }
        
            
            if taskViewController.task?.identifier == "ClockTask"{
                if reason == .completed {
                    
                    var ScoreClockTask: ORKOrderedTask{
                        
                        var steps = [ORKStep]()
        
                        let imageScoreStepImage = crop(image: loadImage(fileName: "imageStep.jpg")!,withWidth: 2000, andHeight: 2000)!
                        let imageTitle = "Score the clock"
                        let imageFormStep = ORKFormStep(identifier: "imageFormStep", title: imageTitle, text: "")
                        
                        let imageAnswerChoice = ORKImageChoice(normalImage: imageScoreStepImage, selectedImage: imageScoreStepImage, text: "", value: 0 as NSCoding & NSCopying & NSObjectProtocol)
                        let imageChoiceAnswerFormat = ORKImageChoiceAnswerFormat(imageChoices: [imageAnswerChoice])
                        let imageItem = ORKFormItem(identifier: "imageItem", text: "", answerFormat: imageChoiceAnswerFormat)
                        
                        let textChoices = [
                            ORKTextChoice(text: "Contour", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                            ORKTextChoice(text: "Numbers", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                            ORKTextChoice(text: "Hands", value: 2 as NSCoding & NSCopying & NSObjectProtocol) ]
                        
                        let textChoicesFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: textChoices)
                        
                        let scoreItem = ORKFormItem(identifier: "scoreItem", text: "AI recomends contour numbers", answerFormat: textChoicesFormat, optional: true)
                        
                        imageFormStep.isOptional = true
                        imageFormStep.formItems = [imageItem,scoreItem]
                    
                        
                        steps += [imageFormStep]
                        
                        
                        return ORKOrderedTask(identifier: "ScoreClockTask", steps: steps)
                        
                    }
                    
                    let scoreTaskViewController = ORKTaskViewController(task: ScoreClockTask, taskRun: nil)
                    scoreTaskViewController.delegate = self
                    
                    present(scoreTaskViewController, animated: true, completion: nil)
                   
                }
                
            }
        
            if taskViewController.task?.identifier == "ScoreClockTask"{
                if reason == .completed {
                
                    ExtractClockScores(taskController: taskViewController)
             
                    control?.clockComplete = true
                    
                    PersistenceService.saveContext()
                    
                }
            }
            
        if (control != nil) {
            
            control = checkTaskCompletions(control: control!)
            
            PersistenceService.saveContext()
            
        }
        else { print("Control doesnt exist") }
            
        } catch {
            print("hit control failure")
            present(callError(), animated: true, completion: nil)}
    }
}
