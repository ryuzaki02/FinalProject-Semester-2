//
//  FoodPairingDB+CoreDataProperties.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//
//

import Foundation
import CoreData


extension FoodPairingDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodPairingDB> {
        return NSFetchRequest<FoodPairingDB>(entityName: "FoodPairingDB")
    }

    @NSManaged public var name: String?

}

extension FoodPairingDB : Identifiable {

}
