//
//  Subject+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-05-23.
//  Copyright © 2018 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var age: Int16
    @NSManaged public var date: String?
    @NSManaged public var education: Int16
    @NSManaged public var height: String?
    @NSManaged public var name: String?
    @NSManaged public var sex: Bool
    @NSManaged public var weight: String?
    @NSManaged public var abstract: Abstraction?
    @NSManaged public var apnea: Apnea?
    @NSManaged public var clock: Clock?
    @NSManaged public var memory: Memory?
    @NSManaged public var mood: Mood?

}
