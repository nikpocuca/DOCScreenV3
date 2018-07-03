//
//  Memory+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-03.
//  Copyright © 2018 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memory> {
        return NSFetchRequest<Memory>(entityName: "Memory")
    }

    @NSManaged public var churchCC: Bool
    @NSManaged public var churchMC: Bool
    @NSManaged public var churchRegT1: Bool
    @NSManaged public var churchRegT2: Bool
    @NSManaged public var churchWC: Bool
    @NSManaged public var daisyCC: Bool
    @NSManaged public var daisyMC: Bool
    @NSManaged public var daisyRegT1: Bool
    @NSManaged public var daisyRegT2: Bool
    @NSManaged public var daisyWC: Bool
    @NSManaged public var faceCC: Bool
    @NSManaged public var faceMC: Bool
    @NSManaged public var faceRegT1: Bool
    @NSManaged public var faceRegT2: Bool
    @NSManaged public var faceWC: Bool
    @NSManaged public var memoryScore: Int16
    @NSManaged public var redCC: Bool
    @NSManaged public var redMC: Bool
    @NSManaged public var redRegT1: Bool
    @NSManaged public var redRegT2: Bool
    @NSManaged public var redWC: Bool
    @NSManaged public var velvetCC: Bool
    @NSManaged public var velvetMC: Bool
    @NSManaged public var velvetRegT1: Bool
    @NSManaged public var velvetRegT2: Bool
    @NSManaged public var velvetWC: Bool
    @NSManaged public var subject: Subject?

}
