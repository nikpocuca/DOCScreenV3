//
//  PageViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-11.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit
import CoreData
import SwiftCarousel


class PageViewController: UIViewController,UIDocumentInteractionControllerDelegate, SwiftCarouselDelegate {
    
    
    @IBOutlet weak var TaskCarousel: SwiftCarousel!
    var taskImages: [UIImage]?
    var imageViews: [UIImageView]?
    let infoTitleLabels = ["Profile","Memory","Sleep","Abstraction","Mood","Clock"]
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var presentInfoView: UIView!
    
    // Need to change this to fit your task carousel.
    
    // create image view ?
    
    func imageViewForTask(image: UIImage) -> UIImageView {
        let taskImageView = UIImageView(image: image)
        
        taskImageView.backgroundColor = UIColor.red
        return(taskImageView)
    }
    

    
    func BuildProfileView() -> Void {
        
    presentInfoView.backgroundColor = UIColor.red
        
    }
    
    
    
    func DrawProfileView(view: UIView) -> Void{
    
        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
        
        do {
            
            let subjectArray = try PersistenceService.context.fetch(fetchRequest)
            
            // theres only one subject.
            let subject = subjectArray.first
            
            let y = view.frame.origin.y
            
            let fullView = UIView(frame: CGRect(x: 0, y: y, width: 375, height: 120))
            
            // Style Function
            func LabelStyle(label: UILabel) -> Void {
                label.textAlignment = .center
                label.layer.borderWidth = 1
            }
            
            // Generate Age Title
            let ageTitleLabel = UILabel(frame: CGRect(x: 0, y: y, width: 125, height: 30))
            ageTitleLabel.text = "Age"
            ageTitleLabel.textAlignment = .center
            ageTitleLabel.layer.borderWidth = 1
            
            fullView.addSubview(ageTitleLabel)
            
            // Number of Age
            let ageNumberLabel = UILabel(frame: CGRect(x: 0, y: y+30, width: 125, height: 50))
            ageNumberLabel.text = String((subject?.age)!)
            ageNumberLabel.textAlignment = .center
            ageNumberLabel.layer.borderWidth = 1
            
            fullView.addSubview(ageNumberLabel)
            
            // Education Title
            let eduTitleLabel = UILabel(frame: CGRect(x: 125, y: y, width: 125, height: 30))
            eduTitleLabel.text = "Education"
            eduTitleLabel.textAlignment = .center
            eduTitleLabel.layer.borderWidth = 1
            
            fullView.addSubview(eduTitleLabel)
            
            // Education Number
            let eduNumberLabel = UILabel(frame: CGRect(x: 125, y: y+30, width: 125, height: 50))
            eduNumberLabel.text = String((subject?.education)!)
            eduNumberLabel.textAlignment = .center
            eduNumberLabel.layer.borderWidth = 1
            
            fullView.addSubview(eduNumberLabel)
            
            // Sex Title
            let sexTitle = UILabel(frame: CGRect(x: 250, y: y, width: 125, height: 30))
            sexTitle.text = "Sex"
            sexTitle.textAlignment = .center
            sexTitle.layer.borderWidth = 1
            
            fullView.addSubview(sexTitle)
            
            // Sex Label
            
            func sexToString(inputBool: Bool) -> String{
                switch inputBool {
                case true:
                    return("Male")
                default:
                    return("Female")
                }
            }
            
            let sexLabel = UILabel(frame: CGRect(x: 250, y: y+30, width: 125, height: 50))
            sexLabel.text = sexToString(inputBool: (subject?.sex)!)
            sexLabel.textAlignment = .center
            sexLabel.layer.borderWidth = 1
            
            fullView.addSubview(sexLabel)
            
            // Weight Title
            let weightTitle = UILabel(frame: CGRect(x: 0, y: y+80, width: 125, height: 30))
            weightTitle.text = "Weight"
            LabelStyle(label: weightTitle)
            fullView.addSubview(weightTitle)
            
            // Height Title
            let heightTitle = UILabel(frame: CGRect(x: 125, y: y+80, width: 125, height: 30))
            heightTitle.text = "Height"
            LabelStyle(label: heightTitle)
            fullView.addSubview(heightTitle)
            
            // BMI Title
            let bmiTitle = UILabel(frame: CGRect(x: 250, y: y+80, width: 125, height: 30))
            bmiTitle.text = "BMI"
            LabelStyle(label: bmiTitle)
            fullView.addSubview(bmiTitle)
            
            // Weight Number
            let weightNumberLabel = UILabel(frame: CGRect(x: 0, y: y+110, width: 125, height: 50))
            weightNumberLabel.text = (subject?.weight)!
            LabelStyle(label: weightNumberLabel)
            fullView.addSubview(weightNumberLabel)
            
            // Height Number
            let heightNumberLabel = UILabel(frame: CGRect(x: 125, y: y+110, width: 125, height: 50))
            heightNumberLabel.text = (subject?.height)!
            LabelStyle(label: heightNumberLabel)
            fullView.addSubview(heightNumberLabel)
            
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
            
            // BMI Number
            let bmiNumberLabel = UILabel(frame: CGRect(x: 250, y: y+110, width: 125, height: 50))
            bmiNumberLabel.text = bmiToString(inputHeight: (subject?.height)!, inputWeight: (subject?.weight)!)
            LabelStyle(label: bmiNumberLabel)
            fullView.addSubview(bmiNumberLabel)
            
            fullView.tag = 200
            
            view.addSubview(fullView)
        }
            
        catch {print("Place view Controller that says Alert there is no subject yet")}
        
    }
    

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
/*
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
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskImages = [#imageLiteral(resourceName: "profile"),#imageLiteral(resourceName: "memory"),#imageLiteral(resourceName: "sleep"),#imageLiteral(resourceName: "abstraction"),#imageLiteral(resourceName: "mood"),#imageLiteral(resourceName: "clock")]
      
        imageViews = taskImages!.map( {imageViewForTask(image: $0)})
        
        TaskCarousel.items = imageViews!
        
        TaskCarousel.defaultSelectedIndex = 0
        TaskCarousel.delegate = self
        TaskCarousel.scrollType = .default
        TaskCarousel.resizeType = .floatWithSpacing(10);
        
        TaskCarousel.backgroundColor = UIColor.white
        
        infoTitleLabel.text = "Profile"
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func didSelectItem(item: UIView, index: Int, tapped: Bool) -> UIView? {
        if let taskImage = item as? UIImageView {
            
            infoTitleLabel.text = infoTitleLabels[index]
            print(index)
            
            if index == 5 {
                
                var clockImageView = UIImageView(image: loadImage(fileName: "imageStep.jpg")!)
                
                clockImageView.frame = CGRect(x: 30, y: 60, width: 200, height: 300)
                
                clockImageView.contentMode = .scaleAspectFit
                
                clockImageView.tag = 100
                
                presentInfoView.addSubview(clockImageView)
                
            }
            
            if index == 0 {
                
                DrawProfileView(view: presentInfoView)
                
            }
            
            return taskImage
        }
        return item
    }
    
    func didDeselectItem(item: UIView, index: Int) -> UIView? {
         if let taskImage = item as? UIImageView {
            
            if let viewWithTag = self.view.viewWithTag(100) {
                print("Tag 100")
                viewWithTag.removeFromSuperview()
            }
            if let viewWithTag = self.view.viewWithTag(200) {
                print("Tag 200")
                viewWithTag.removeFromSuperview()
            }
            else {
                
                print("tag not found")
            }
            
            return taskImage
        }
        return item
    }
    
    // Carousel Delegates.
    func didEndDragging(withOffset offset: CGPoint) {
        
        
        print("Ended drag")
    }

    func didScroll(toOffset offset: CGPoint) {
        presentInfoView.backgroundColor = UIColor.white
        
        if let viewWithTag = self.view.viewWithTag(100) {
            print("Tag 100")
            viewWithTag.removeFromSuperview()
        }
        else {
            print("tag not found")
        }
        
        
      print("Scrolling")
    }
    
    // Draw Profile View Controller
    
    
    
}
