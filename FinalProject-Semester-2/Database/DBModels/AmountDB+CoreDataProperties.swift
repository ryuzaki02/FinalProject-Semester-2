//
//  AmountDB+CoreDataProperties.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//
//

import Foundation
import CoreData


extension AmountDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AmountDB> {
        return NSFetchRequest<AmountDB>(entityName: "AmountDB")
    }

    @NSManaged public var value: Double
    @NSManaged public var unit: String?

}

extension AmountDB : Identifiable {

}
