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
    
    // Need to change this to fit your task carousel. 
    
    // create image view ?
    
    func imageViewForTask(image: UIImage) -> UIImageView {
        return(UIImageView(image: image))
    }
    
    /*
    let carouselFrame = CGRect(x: view.center.x - 200.0, y: view.center.y - 100.0, width: 400.0, height: 200.0)
    carouselView = SwiftCarousel(frame: carouselFrame)
    try! carouselView.itemsFactory(itemsCount: 5) { choice in
    let imageView = UIImageView(image: UIImage(named: "puppy\(choice+1)"))
    imageView.frame = CGRect(origin: .zero, size: CGSize(width: 200.0, height: 200.0))
    
    return imageView
    }
    carouselView.resizeType = .withoutResizing(10.0)
    carouselView.delegate = self
    carouselView.defaultSelectedIndex = 2
    view.addSubview(carouselView)
    */
    
    
/*
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
        TaskCarousel.resizeType = .visibleItemsPerPage(3)
        TaskCarousel.defaultSelectedIndex = 3
        TaskCarousel.delegate = self
        TaskCarousel.scrollType = .default
        
        TaskCarousel.backgroundColor = UIColor.red
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    // Carousel Delegates.
    func didEndDragging(withOffset offset: CGPoint) {
        print("Ended drag")
    }

    func didScroll(toOffset offset: CGPoint) {
      print("Scrolling")
    }
    
}
