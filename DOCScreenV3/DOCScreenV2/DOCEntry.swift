//
//  DOCEntry.swift
//  DOCScreenV2
//
//  Created by Nik on 2017-10-02.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

class DocEntry {
    
    
    var taskName: String  = "Blank"
    var image: UIImage?
    var completeString: String = "Blank"
    var taskIdentifier = ORKOrderedTask.init(identifier: "Blank", steps: [ORKStep]())
    
    
    init?(TaskName: String, Image: UIImage, CompleteString: String, Task: ORKOrderedTask ) {
        self.taskName = TaskName;
        self.image = Image;
        self.taskIdentifier = Task
 
    }

    
}
