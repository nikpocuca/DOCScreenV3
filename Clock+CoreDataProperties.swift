//
//  Clock+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-08-14.
//  Copyright © 2018 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension Clock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clock> {
        return NSFetchRequest<Clock>(entityName: "Clock")
    }

    @NSManaged public var clockScore: Int16
    @NSManaged public var contour: Bool
    @NSManaged public var hands: Bool
    @NSManaged public var numbers: Bool
    @NSManaged public var subject: Subject?

}
