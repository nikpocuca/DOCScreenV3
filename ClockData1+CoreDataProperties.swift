//
//  ClockData1+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2017-11-03.
//  Copyright © 2017 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension ClockData1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClockData1> {
        return NSFetchRequest<ClockData1>(entityName: "ClockData1")
    }

    @NSManaged public var contour: Int16
    @NSManaged public var hands: Int16
    @NSManaged public var numbers: Int16
    @NSManaged public var subject: Subject?

}
