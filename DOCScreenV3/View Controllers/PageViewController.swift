//
//  PageViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-11.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit
import SwiftCarousel
import CoreData



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
        
        //taskImageView.backgroundColor = UIColor.red

        return(taskImageView)
    }
    
    

    @IBAction func CompilePDF(_ sender: Any) {
        
        let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
        
        do {
            
            let controlArray = try PersistenceService.context.fetch(fetchRequest)
            
            let control = controlArray.first
        
            if (control != nil && control?.fullComplete != nil && control?.fullComplete == true) {
            
            CreatePDF()
        
            let path = NSTemporaryDirectory().appending("sample1.pdf")
            
            let documentInteractionController = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            documentInteractionController.delegate = self
            documentInteractionController.presentPreview(animated: true)
            
            }
                
            else {
                present(callErrorAlert(title: "Not complete", msg: "You have not completed the DOC Screen"), animated: true, completion: nil)
            }
            
        } catch { present(callErrorAlert(title: "No Data", msg: "No data has been entered."), animated: true, completion: nil)}
        
        
    }
    //MARK: UIDocumentInteractionController delegates

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskImages = [#imageLiteral(resourceName: "profileRedBack"),#imageLiteral(resourceName: "memoryRedBack"),#imageLiteral(resourceName: "sleepRedBack"),#imageLiteral(resourceName: "abstractionRedBack"),#imageLiteral(resourceName: "moodRedBack"),#imageLiteral(resourceName: "clockRedBack")]
      
        imageViews = taskImages!.map( {imageViewForTask(image: $0)})
        
        TaskCarousel.items = imageViews!
        
        TaskCarousel.defaultSelectedIndex = 0
        TaskCarousel.delegate = self
        TaskCarousel.scrollType = .default
        TaskCarousel.resizeType = .withoutResizing(15)
        
        TaskCarousel.backgroundColor = UIColor.white
        
        
        let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
        
        do {
            
            let controlArray = try PersistenceService.context.fetch(fetchRequest)
            
            let control = controlArray.first
        
            if control != nil {
                
                if control?.profileComplete == true {
                    
                    infoTitleLabel.text = "Profile"
                    
                    DrawProfileView(view: presentInfoView,viewController: self)
                    
                }
                
                else { present(callErrorAlert(title: "No Subject", msg: "Error you have not started a screen, please select the Profile Task."), animated: true, completion: nil) }
            }
            
            else { present(callErrorAlert(title: "No Subject", msg: "Error you have not started a screen, please start the Profile Task."), animated: true, completion: nil)  }
            
        } catch { present(callErrorAlert(title: "No Data", msg: "No data has been entered."), animated: true, completion: nil) }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func didSelectItem(item: UIView, index: Int, tapped: Bool) -> UIView? {
        if let taskImage = item as? UIImageView {
            
            infoTitleLabel.text = infoTitleLabels[index]
            print(index)
            
            let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
            
            do {
                
                let controlArray = try PersistenceService.context.fetch(fetchRequest)
                
                let control = controlArray.first
                
                switch index  {

                case 0:
                    if control?.profileComplete == true { DrawProfileView(view: presentInfoView,viewController: self) }
                            
                    else { present(callErrorAlert(title: "No Subject", msg: "Error you have not started a screen, please select the Profile Task."), animated: true, completion: nil) }
                case 1:
                    if control?.memoryComplete == true { DrawMemoryView(view: presentInfoView,viewController: self) }
                      
                    else { present(callErrorAlert(title: "No Memory Section", msg: "Error you have not completed the memory section, do the memory registriation, and test."), animated: true, completion: nil) }
                case 2:
                    if control?.apneaComplete == true { DrawApneaView(view: presentInfoView, viewController: self)  }
                 
                    else { present(callErrorAlert(title: "No Sleep Section", msg: "Error you have not completed the sleep section, do the Sleep task."), animated: true, completion: nil) }
                case 3:
                    if control?.abstractionComplete == true { DrawAbstractView(view: presentInfoView, viewController: self) }
                    
                    else { present(callErrorAlert(title: "No Abstraction Section", msg: "Error you have not completed the abstraction section, do the Abstraction task."), animated: true, completion: nil) }
                case 4:
                    if control?.moodComplete == true {   DrawMoodView(view: presentInfoView, viewController: self)}
                    
                    else {
                        present(callErrorAlert(title: "No Mood Section", msg: "Error you have not completed the mood section, do the Mood task."), animated: true, completion: nil) }
                case 5:
                    if control?.clockComplete == true { DrawClockView(view: presentInfoView, viewController: self) }
                    
                    else {
                        present(callErrorAlert(title: "No Clock Section", msg: "Error you have not completed the clock section, do the Clock task."), animated: true, completion: nil)
                    }
                default:
                    present(callErrorAlert(title: "No selection", msg: "You have not selected anything."), animated: true, completion: nil)
                    }
                } catch { present(callErrorAlert(title: "No Data", msg: "No data has been entered."), animated: true, completion: nil) }
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
            if let viewWithTag = self.view.viewWithTag(300) {
                print("Tag 300")
                viewWithTag.removeFromSuperview()
            }
            if let viewWithTag = self.view.viewWithTag(400) {
                print("Tag 400")
                viewWithTag.removeFromSuperview()
            }
            if let viewWithTag = self.view.viewWithTag(500) {
                print("Tag 500")
                viewWithTag.removeFromSuperview()
            }
                
            if let viewWithTag = self.view.viewWithTag(600) {
                print("Tag 600")
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
        
      print("Scrolling")
    }
    
    
}
