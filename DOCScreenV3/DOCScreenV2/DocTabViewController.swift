//
//  DocTabViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-05.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit

class DocTabViewController: UITabBarController {
    
    required init?(coder aDecoder: NSCoder) {
        
        
        super.init(coder: aDecoder)
        
        
        // load view controllers
        self.viewControllers = [
            createTasksViewController(),
            createPageViewController()
    
        ]
        
    }

    fileprivate func createTasksViewController() -> UINavigationController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let taskViewController = mainStoryboard.instantiateViewController(withIdentifier: "TaskTableViewController")
        
   
        
        taskViewController.tabBarItem = UITabBarItem(title: "Tasks", image: #imageLiteral(resourceName: "hand"), selectedImage: #imageLiteral(resourceName: "hand"))
      
        let nav = UINavigationController(rootViewController: taskViewController)
        
        return nav
    }

    
    fileprivate func createPageViewController() -> UINavigationController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pageViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageViewController")
        
        pageViewController.tabBarItem = UITabBarItem(title: "Form", image: #imageLiteral(resourceName: "task_30") , selectedImage: #imageLiteral(resourceName: "task_30"))

        
        let nav = UINavigationController(rootViewController: pageViewController)
        
        return nav
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.docRed()
        
        self.view.tintColor = UIColor.docRed()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

   
}
