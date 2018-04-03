//
//  Person+CoreDataProperties.swift
//  Persistence
//
//  Created by taehoon lee on 2018. 4. 3..
//  Copyright © 2018년 taehoon lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
