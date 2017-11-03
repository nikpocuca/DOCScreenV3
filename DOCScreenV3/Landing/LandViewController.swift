//
//  LandViewController.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-05.
//  Copyright © 2017 Nik. All rights reserved.
//

import UIKit

class LandViewController: UIViewController {

   
    @IBOutlet weak var beginOut: UIButton!
    
    @IBOutlet weak var memoryOut: UIImageView!
    
    @IBOutlet weak var clockOut: UIImageView!
    
    @IBOutlet weak var abstractOut: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
