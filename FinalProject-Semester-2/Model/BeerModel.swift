//
//  BeerModel.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-03.
//

import Foundation

struct BeerModel: Codable {
    var id: String
    var name: String
    var tagline: String
    var first_brewed: String
    var description: String
    var ph: String
    var attenuation_level: String
    var volume: Volume
    var food_pairing: [FoodPairing]
    var brewers_tips: String
    var ingredients: Ingredients
}

struct Volume: Codable {
    var value: String
    var unit: String
}

struct FoodPairing: Codable {
    var item: String
}

struct Ingredients: Codable {
    var malt: [Malt]
    var hops: [Hop]
    var yeast: String
}

struct Malt: Codable {
    var name: String
    var amount: MaltAmount
}

struct MaltAmount: Codable {
    var value: String
    var unit: String
}

struct Hop: Codable {
    var name: String
    var amount: MaltAmount
    var add: String
    var attribute: String
}
