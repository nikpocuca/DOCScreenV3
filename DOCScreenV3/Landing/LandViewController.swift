//
//  LandViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-05.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit
import ResearchKit
import CoreData

class LandViewController: UIViewController {

   
    @IBOutlet weak var beginOut: UIButton!
    
    @IBOutlet weak var memoryOut: UIImageView!
    
    @IBOutlet weak var clockOut: UIImageView!
    
    @IBOutlet weak var abstractOut: UIImageView!
    
    
    @IBAction func beginTapped(_ sender: Any) {
        
        let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
        
        do {
            let controlArray = try PersistenceService.context.fetch(fetchRequest)
            var control = controlArray.first
            
            if control == nil {
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
            
            PersistenceService.saveContext()
            
            if control?.consentComplete == true {
                let navViewController = self.storyboard?.instantiateViewController(withIdentifier: "TaskNavViewController") as! TaskNavViewController
                self.present(navViewController, animated: true, completion: nil)
            }
            
            
            if control?.consentComplete == false {
                
                let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
                taskViewController.delegate = self
                
                present(taskViewController, animated: true, completion: nil)
                
            }
            
        } catch {
            print("hit control failure")
            present(callError(), animated: true, completion: nil)}
            
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        UIView.appearance().tintColor = UIColor.docRed()
        
        
        abstractOut.layer.borderWidth = 1;
      abstractOut.layer.borderColor = UIColor.docRed().cgColor
        abstractOut.layer.cornerRadius = 50;
        
        memoryOut.layer.borderWidth = 1;
        memoryOut.layer.borderColor = UIColor.docRed().cgColor
        memoryOut.layer.cornerRadius = 50;
        
        
        clockOut.layer.borderWidth = 1;
        clockOut.layer.borderColor = UIColor.docRed().cgColor
        clockOut.layer.cornerRadius = 50;
        
        
        
        beginOut.layer.borderWidth = 1;
        beginOut.layer.borderColor = UIColor.docRed().cgColor
        beginOut.layer.cornerRadius = 4


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension LandViewController:  ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        
        if taskViewController.task?.identifier == "ConsentTask"{
            if reason == .completed {
                
                
                let consentResults = taskViewController.result.stepResult(forStepIdentifier: "ConsentReviewStep")
                
                let consentSignatureResult = consentResults?.results![0] as! ORKConsentSignatureResult
                
                let consentedResult = consentSignatureResult.consented
                
                let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
                
                do {
                    let controlArray = try PersistenceService.context.fetch(fetchRequest)
                    let control = controlArray.first
                    
                    control?.consentComplete = consentedResult
                    
                    PersistenceService.saveContext()
                    
                } catch {
                    print("hit control failure")
                    present(callError(), animated: true, completion: nil)}
                
                ReviewInfo.isCompleted = consentedResult
                
                if ReviewInfo.isCompleted == true {
                    
                    
                    let navViewController = self.storyboard?.instantiateViewController(withIdentifier: "TaskNavViewController") as! TaskNavViewController
                   self.present(navViewController, animated: true, completion: nil)
                    
                }
                
            }
        }
    }
    
    
    
}
