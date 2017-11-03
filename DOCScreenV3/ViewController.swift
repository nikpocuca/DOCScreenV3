//
//  ViewController.swift
//  DOCScreenV3
//
//  Created by Nik on 2017-11-03.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    let subject = Subject(context: PersistenceService.context)

        let clockData = ClockData1(context: PersistenceService.context)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

