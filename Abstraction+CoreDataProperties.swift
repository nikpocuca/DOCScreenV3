//
//  Abstraction+CoreDataProperties.swift
//  DOCScreenV3
//
//  Created by Nik on 2018-05-23.
//  Copyright © 2018 Nik. All rights reserved.
//
//

import Foundation
import CoreData


extension Abstraction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Abstraction> {
        return NSFetchRequest<Abstraction>(entityName: "Abstraction")
    }

    @NSManaged public var abstractScore: Int16
    @NSManaged public var q1BoolScore: Bool
    @NSManaged public var q2BoolScore: Bool
    @NSManaged public var subject: Subject?

}
