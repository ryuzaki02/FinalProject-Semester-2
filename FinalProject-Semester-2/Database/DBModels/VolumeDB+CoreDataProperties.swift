//
//  VolumeDB+CoreDataProperties.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//
//

import Foundation
import CoreData


extension VolumeDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VolumeDB> {
        return NSFetchRequest<VolumeDB>(entityName: "VolumeDB")
    }

    @NSManaged public var value: Int16
    @NSManaged public var unit: String?

}

extension VolumeDB : Identifiable {

}
