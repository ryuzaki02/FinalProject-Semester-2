//
//  HopDB+CoreDataProperties.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//
//

import Foundation
import CoreData


extension HopDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HopDB> {
        return NSFetchRequest<HopDB>(entityName: "HopDB")
    }

    @NSManaged public var name: String?
    @NSManaged public var add: String?
    @NSManaged public var attribute: String?
    @NSManaged public var toAmount: AmountDB?

}

extension HopDB : Identifiable {

}
