//
//  Mood+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-08-14.
//  Copyright © 2018 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood")
    }

    @NSManaged public var moodScore: Int16
    @NSManaged public var q1Mood: Int16
    @NSManaged public var q2Mood: Int16
    @NSManaged public var subject: Subject?

}
