//
//  Subject+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2017-11-03.
//  Copyright © 2017 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var abstractScore: Int16
    @NSManaged public var age: Int16
    @NSManaged public var apneaScore: Int16
    @NSManaged public var clockImage: NSData?
    @NSManaged public var clockScore: Int16
    @NSManaged public var date: String?
    @NSManaged public var education: String?
    @NSManaged public var height: Float
    @NSManaged public var memoryScore: Int16
    @NSManaged public var moodScore: Int16
    @NSManaged public var name: String?
    @NSManaged public var sex: String?
    @NSManaged public var weight: Int16
    @NSManaged public var clockData: ClockData1?

}
