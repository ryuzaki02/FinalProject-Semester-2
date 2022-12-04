//
//  DatabaseManager.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-04.
//

import Foundation
import UIKit
import CoreData

// Class handles methods to save, update, delete and fetch operations
//
class DatabaseManager {
    
    // MARK: - Variables
    
    // Singleton instance to the class
    static var shared = DatabaseManager()
    
    // Provides object of AppDelegate class
    private var appDelegate: AppDelegate? {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return nil
                }
        return appDelegate
    }
    
    // Provides object of managed object context
    private var managedContext: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext ?? nil
    }
    
    // MARK: - Member functions
    
    // Method that saves the beer model to database
    // params: beers: [BeerModel]
    // returns: nothing
    //
    func saveBeersToDBFor(beers: [BeerModel]) {
        guard let managedContext = managedContext else {
            return
        }
        for beer in beers {
            if let beerId = beer.id,
               fetchBeerForId(beerId: beerId) == nil {
                let entity = NSEntityDescription.entity(forEntityName: "BeerDB", in: managedContext)!
                let beerDB = NSManagedObject(entity: entity, insertInto: managedContext) as! BeerDB
                
                beerDB.id = Int16(beer.id ?? 0)
                beerDB.name = beer.name ?? ""
                beerDB.tagLine = beer.tagline ?? ""
                beerDB.firstBrewed = beer.first_brewed ?? ""
                beerDB.beerDesc = beer.description ?? ""
                beerDB.ph = beer.ph ?? 0.0
                beerDB.attenuationLevel = beer.attenuation_level ?? 0.0
                beerDB.brewersTips = beer.brewers_tips ?? ""
                
                saveFoodPairingToDBFor(beer: beer, dbModel: beerDB)
                if let volume = beer.volume {
                    saveVolumeToDBFor(volume: volume, dbModel: beerDB)
                }
                if let ing = beer.ingredients {
                    saveIngredientsToDBFor(ingredients: ing, dbModel: beerDB)
                }
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    private func saveFoodPairingToDBFor(beer: BeerModel, dbModel: BeerDB) {
        guard let managedContext = managedContext else {
            return
        }
        for item in beer.food_pairing ?? [] {
            let entity = NSEntityDescription.entity(forEntityName: "FoodPairingDB", in: managedContext)!
            let foodPairingDB = NSManagedObject(entity: entity, insertInto: managedContext) as! FoodPairingDB
            foodPairingDB.name = item
            dbModel.addToToFoodPairing(foodPairingDB)
        }
    }
    
    private func saveVolumeToDBFor(volume: Volume, dbModel: BeerDB) {
        guard let managedContext = managedContext else {
            return
        }
        let entity = NSEntityDescription.entity(forEntityName: "VolumeDB", in: managedContext)!
        let volumeDB = NSManagedObject(entity: entity, insertInto: managedContext) as! VolumeDB
        volumeDB.unit = volume.unit ?? ""
        volumeDB.value = Int16(volume.value ?? 0)
        dbModel.toVolume = volumeDB
    }
    
    private func saveIngredientsToDBFor(ingredients: Ingredients, dbModel: BeerDB) {
        guard let managedContext = managedContext else {
            return
        }
        let entity = NSEntityDescription.entity(forEntityName: "IngredientsDB", in: managedContext)!
        let ingDB = NSManagedObject(entity: entity, insertInto: managedContext) as! IngredientsDB
        ingDB.yeast = ingredients.yeast ?? ""
        saveMaltToDBFor(malts: ingredients.malt ?? [], dbModel: ingDB)
        saveHopToDBFor(hops: ingredients.hops ?? [], dbModel: ingDB)
        dbModel.toIngredient = ingDB
    }
    
    private func saveMaltToDBFor(malts: [Malt], dbModel: IngredientsDB) {
        guard let managedContext = managedContext else {
            return
        }
        for malt in malts {
            let entity = NSEntityDescription.entity(forEntityName: "MaltDB", in: managedContext)!
            let maltDB = NSManagedObject(entity: entity, insertInto: managedContext) as! MaltDB
            maltDB.name = malt.name ?? ""
            if let maltAmt = malt.amount,
                let toAmount = saveAmountToDBFor(maltAmt: maltAmt)  {
                maltDB.toAmount = toAmount
            }
            dbModel.addToToMalt(maltDB)
        }
    }
    
    private func saveHopToDBFor(hops: [Hop], dbModel: IngredientsDB) {
        guard let managedContext = managedContext else {
            return
        }
        for hop in hops {
            let entity = NSEntityDescription.entity(forEntityName: "HopDB", in: managedContext)!
            let hopDB = NSManagedObject(entity: entity, insertInto: managedContext) as! HopDB
            hopDB.name = hop.name ?? ""
            hopDB.add = hop.add ?? ""
            hopDB.attribute = hop.attribute ?? ""
            if let hopAmt = hop.amount,
                let toAmount = saveAmountToDBFor(maltAmt: hopAmt)  {
                hopDB.toAmount = toAmount
            }
            dbModel.addToToHop(hopDB)
        }
    }
    
    private func saveAmountToDBFor(maltAmt: MaltAmount) -> AmountDB? {
        guard let managedContext = managedContext else {
            return nil
        }
        let entity = NSEntityDescription.entity(forEntityName: "AmountDB", in: managedContext)!
        let amountDB = NSManagedObject(entity: entity, insertInto: managedContext) as! AmountDB
        amountDB.unit = maltAmt.unit
        amountDB.value = maltAmt.value ?? 0.0
        return amountDB
    }
    
    
    // Method that fetches all the saved beer models from database
    // params: nothing
    // returns: Array of BeerModel Objects
    //
    func fetchAllBeers() -> [BeerModel]? {
        guard let managedContext = managedContext else {
            return nil
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BeerDB")
        do
        {
            if let objects = try managedContext.fetch(request) as? [BeerDB] {
                var beerModels = [BeerModel]()
                for beerDb in objects {
                    
                    let volume = Volume(value: Int(beerDb.toVolume?.value ?? 0), unit: beerDb.toVolume?.unit ?? "")
                    
                    var malts = [Malt]()
                    if let dbMalts = beerDb.toIngredient?.toMalt?.allObjects as? [MaltDB] {
                        for malt in dbMalts {
                            let maltAmt = MaltAmount(value: malt.toAmount?.value ?? 0.0, unit: malt.toAmount?.unit ?? "")
                            malts.append(Malt(name: malt.name, amount: maltAmt))
                        }
                    }
                    
                    var hops = [Hop]()
                    if let dbHops = beerDb.toIngredient?.toHop?.allObjects as? [HopDB] {
                        for hop in dbHops {
                            let hopAmt = MaltAmount(value: hop.toAmount?.value ?? 0.0, unit: hop.toAmount?.unit ?? "")
                            hops.append(Hop(name: hop.name ?? "", amount: hopAmt, add: hop.add ?? "", attribute: hop.attribute ?? ""))
                        }
                    }
                    
                    
                    let ingredients = Ingredients(malt: malts, hops: hops, yeast: beerDb.toIngredient?.yeast ?? "")
                    
                    var beerModel = BeerModel(id: Int(beerDb.id), name: beerDb.name, tagline: beerDb.tagLine, first_brewed: beerDb.firstBrewed, description: beerDb.description, ph: beerDb.ph, attenuation_level: beerDb.attenuationLevel, volume: volume, food_pairing: (beerDb.toFoodPairing?.allObjects as! [String]), brewers_tips: beerDb.brewersTips, ingredients: ingredients)
                    beerModels.append(beerModel)
                }
                return beerModels
            }
        }
        catch
        {

        }
        return nil
    }
    
    // Method that fetches single beer model database object from database
    // params: beerId: String
    // returns: BeerDB object
    //
    private func fetchBeerForId(beerId: Int) -> BeerDB? {
        guard let managedContext = managedContext else {
            return nil
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BeerDB")
        request.predicate = NSPredicate(format: "id = %@", String(beerId))
        do
        {
            if let objects = try managedContext.fetch(request) as? [BeerDB],
               let beerModel = objects.first {
                return beerModel
            }
        }
        catch
        {
            
        }
        return nil
    }
    
}
