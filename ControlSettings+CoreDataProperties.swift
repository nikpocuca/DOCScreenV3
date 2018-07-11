//
//  ControlSettings+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-07-11.
//  Copyright © 2018 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension ControlSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ControlSettings> {
        return NSFetchRequest<ControlSettings>(entityName: "ControlSettings")
    }

    @NSManaged public var fullComplete: Bool
    @NSManaged public var profileComplete: Bool
    @NSManaged public var clockComplete: Bool
    @NSManaged public var moodComplete: Bool
    @NSManaged public var memoryComplete: Bool
    @NSManaged public var apneaComplete: Bool
    @NSManaged public var abstractionComplete: Bool

}
