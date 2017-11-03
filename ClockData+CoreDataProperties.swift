//
//  ClockData+CoreDataProperties.swift
//  
//
//  Created by Nik on 2017-11-03.
//
//

import Foundation
import CoreData


extension ClockData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClockData> {
        return NSFetchRequest<ClockData>(entityName: "ClockData")
    }

    @NSManaged public var contour: Int16
    @NSManaged public var hands: Int16
    @NSManaged public var numbers: Int16
    @NSManaged public var subject: Subject?

}
