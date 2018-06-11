//
//  PageViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-11.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit
import CoreData

class PageViewController: UIViewController,UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    
    @IBOutlet weak var moodScore: UILabel!
    @IBOutlet weak var abstractScore: UILabel!
    @IBOutlet weak var memoryScore: UILabel!
    @IBOutlet weak var apneaScore: UILabel!
    
    @IBOutlet weak var docImage: UIImageView!
    
    @IBOutlet weak var clockScore: UILabel!
    
    
    @IBOutlet weak var educationLabel: UILabel!
    
    
    @IBOutlet weak var contourOut: UIButton!
    
    
    @IBOutlet weak var numbersOut: UIButton!
    
    
    @IBOutlet weak var handsOut: UIButton!
    
    
    @IBAction func CompilePDF(_ sender: Any) {
        
        CreatePDF()
        
      let path = NSTemporaryDirectory().appending("sample1.pdf")
        
        let documentInteractionController = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        documentInteractionController.delegate = self
        documentInteractionController.presentPreview(animated: true)
    
    }
    //MARK: UIDocumentInteractionController delegates

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }


    
    
    override func viewDidAppear(_ animated: Bool) {
        
    
            abstractScore.text = "[   ]"
            moodScore.text = "[   ]"
            clockScore.text = "[       ]"
            memoryScore.text = "[   ]"
            apneaScore.text = "[   ]"
            bmiLabel.text = ""
            weightLabel.text = ""
            ageLabel.text = ""
            heightLabel.text = ""
            
        
       
        }
    
    
    @IBAction func test(_ sender: Any) {
        
        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
        
        do {
            let subjectArray = try PersistenceService.context.fetch(fetchRequest)
            
            for i in subjectArray {
                
                if i.name != nil {
                    print("Name: \(i.name!)")
                    //print("Age: \(i.age)")
                    //print("Sex: \(i.sex)")
                    //print("Education: \(i.education)")
                    //print("Height: \(i.height!)")
                   // print("Weight: \(i.weight!)")
                  //  print("Memory RegT1: \(i.memory?.faceRegT1)")
                  //  print("Memory RegT2: \(i.memory?.faceRegT2)")
                  /*  print("Memory FaceWC: \(i.memory?.faceWC)")
                    print("Memory VelvetWC: \(i.memory?.velvetWC)")
                    print("Memory churchWC: \(i.memory?.churchWC)")
                    print("Memory DaisyWC: \(i.memory?.daisyWC)")
                    print("Memory RedWC: \(i.memory?.redWC)")
                    print("Memory FaceCC: \(i.memory?.faceCC)")
                    print("Memory VelvetCC: \(i.memory?.velvetCC)")
                    print("Memory churchCC: \(i.memory?.churchCC)")
                    print("Memory DaisyCC: \(i.memory?.daisyCC)")
                    print("Memory RedCC: \(i.memory?.redCC)")
                    print("Memory FaceMC: \(i.memory?.faceMC)")
                    print("Memory VelvetMC: \(i.memory?.velvetMC)")
                    print("Memory churchMC: \(i.memory?.churchMC)")
                    print("Memory DaisyMC: \(i.memory?.daisyMC)")
                    print("Memory RedMC: \(i.memory?.redMC)")
                    print("MemoryScore : \(i.memory?.memoryScore)")
              
                
                    print("Mood q1Result: \(i.mood?.q1Mood)")
                    print("Mood q2Result: \(i.mood?.q2Mood)")
                    print("Mood Score: \(i.mood?.moodScore)")
 
                    
                    print("AbstractScore : \(i.abstract?.abstractScore)")
                    print("q1Result: \(i.abstract?.q1BoolScore)")
                    print("q2Result: \(i.abstract?.q2BoolScore)")
 
 
                    
                    print("ApneaScore : \(i.apnea?.apneaScore)")
                    print("q1: \(i.apnea?.q1Score)")
                    print("q2: \(i.apnea?.q2Score)")
                    print("q3: \(i.apnea?.q3Score)")
                    print("q4: \(i.apnea?.q4Score)")
 

                    print("ClockPath \(i.clock?.clockImagePath)")
                    print("Clock Stuff \(i.clock?.clockScore), \(i.clock?.contour) , \(i.clock?.numbers) , \(i.clock?.hands)")
                         */
                    
                    
                    }
 
        
                
            }
        }
        catch {}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
