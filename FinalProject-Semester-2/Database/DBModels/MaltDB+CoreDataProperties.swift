//
//  MaltDB+CoreDataProperties.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//
//

import Foundation
import CoreData


extension MaltDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaltDB> {
        return NSFetchRequest<MaltDB>(entityName: "MaltDB")
    }

    @NSManaged public var name: String?
    @NSManaged public var toAmount: AmountDB?

}

extension MaltDB : Identifiable {

}
