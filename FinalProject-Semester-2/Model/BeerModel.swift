//
//  BeerModel.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-03.
//

import Foundation

struct BeerModel: Codable {
    var id: Int
    var name: String
    var tagline: String
    var first_brewed: String
    var description: String
    var ph: Double
    var attenuation_level: Int
    var volume: Volume
    var food_pairing: [String]
    var brewers_tips: String
    var ingredients: Ingredients
}

struct Volume: Codable {
    var value: Int
    var unit: String
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
    var value: Double
    var unit: String
}

struct Hop: Codable {
    var name: String
    var amount: MaltAmount
    var add: String
    var attribute: String
}
