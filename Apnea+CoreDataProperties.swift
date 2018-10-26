//
//  Apnea+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-08-14.
//  Copyright © 2018 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension Apnea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Apnea> {
        return NSFetchRequest<Apnea>(entityName: "Apnea")
    }

    @NSManaged public var apneaScore: Int16
    @NSManaged public var q1Score: Bool
    @NSManaged public var q2Score: Bool
    @NSManaged public var q3Score: Bool
    @NSManaged public var q4Score: Bool
    @NSManaged public var subject: Subject?

}
