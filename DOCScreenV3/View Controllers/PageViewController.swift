//
//  PageViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-11.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit
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
        
        DrawProfileView(view: presentInfoView)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func didSelectItem(item: UIView, index: Int, tapped: Bool) -> UIView? {
        if let taskImage = item as? UIImageView {
            
            infoTitleLabel.text = infoTitleLabels[index]
            print(index)
            
            switch index  {
            case 0:
                DrawProfileView(view: presentInfoView)
            case 1:
                print("Memory")
                DrawMemoryView(view: presentInfoView)
            case 2:
                print("Sleep")
                DrawApneaView(view: presentInfoView)
            case 3:
                print("Abstraction")
                DrawAbstractView(view: presentInfoView)
            case 4:
                DrawMoodView(view: presentInfoView)
            case 5:
                DrawClockView(view: presentInfoView)
            default:
                print("hit default")
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
