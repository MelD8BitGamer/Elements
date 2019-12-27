//
//  Model.swift
//  Elements
//
//  Created by Melinda Diaz on 12/19/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let atomicMass: Double?
    let boil: Double?
    let discoveredBy: String?
    let melt: Double?
    let number: Int
    let symbol: String
    var favoritedBy: String?
    
//    Coding keys are used to take the RAW DATA that is not swiftly into Swiftly elements by conforming into coding keys like below the cases are how you want it and the string is how it appears in the data
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case atomicMass = "atomic_mass"
        case boil = "boil"
        case discoveredBy = "discovered_by"
        case melt = "melt"
        case number = "number"
        case symbol = "symbol"
        case favoritedBy = "favoritedBy"
    }
    
}
