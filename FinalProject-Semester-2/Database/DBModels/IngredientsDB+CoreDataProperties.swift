//
//  IngredientsDB+CoreDataProperties.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//
//

import Foundation
import CoreData


extension IngredientsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientsDB> {
        return NSFetchRequest<IngredientsDB>(entityName: "IngredientsDB")
    }

    @NSManaged public var yeast: String?
    @NSManaged public var toMalt: NSSet?
    @NSManaged public var toHop: NSSet?

}

// MARK: Generated accessors for toMalt
extension IngredientsDB {

    @objc(addToMaltObject:)
    @NSManaged public func addToToMalt(_ value: MaltDB)

    @objc(removeToMaltObject:)
    @NSManaged public func removeFromToMalt(_ value: MaltDB)

    @objc(addToMalt:)
    @NSManaged public func addToToMalt(_ values: NSSet)

    @objc(removeToMalt:)
    @NSManaged public func removeFromToMalt(_ values: NSSet)

}

// MARK: Generated accessors for toHop
extension IngredientsDB {

    @objc(addToHopObject:)
    @NSManaged public func addToToHop(_ value: HopDB)

    @objc(removeToHopObject:)
    @NSManaged public func removeFromToHop(_ value: HopDB)

    @objc(addToHop:)
    @NSManaged public func addToToHop(_ values: NSSet)

    @objc(removeToHop:)
    @NSManaged public func removeFromToHop(_ values: NSSet)

}

extension IngredientsDB : Identifiable {

}
