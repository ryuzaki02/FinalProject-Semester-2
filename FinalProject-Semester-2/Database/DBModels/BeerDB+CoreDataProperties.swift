//
//  BeerDB+CoreDataProperties.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//
//

import Foundation
import CoreData


extension BeerDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeerDB> {
        return NSFetchRequest<BeerDB>(entityName: "BeerDB")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var tagLine: String?
    @NSManaged public var firstBrewed: String?
    @NSManaged public var beerDesc: String?
    @NSManaged public var ph: Double
    @NSManaged public var attenuationLevel: Double
    @NSManaged public var brewersTips: String?
    @NSManaged public var toVolume: VolumeDB?
    @NSManaged public var toFoodPairing: NSSet?
    @NSManaged public var toIngredient: IngredientsDB?

}

// MARK: Generated accessors for toFoodPairing
extension BeerDB {

    @objc(addToFoodPairingObject:)
    @NSManaged public func addToToFoodPairing(_ value: FoodPairingDB)

    @objc(removeToFoodPairingObject:)
    @NSManaged public func removeFromToFoodPairing(_ value: FoodPairingDB)

    @objc(addToFoodPairing:)
    @NSManaged public func addToToFoodPairing(_ values: NSSet)

    @objc(removeToFoodPairing:)
    @NSManaged public func removeFromToFoodPairing(_ values: NSSet)

}

extension BeerDB : Identifiable {

}
