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
    let atomic_mass: Double
    let boil: Double
    let discovered_by: String
    let melt: Double
    let number: Int
    let symbol: String
    var favoritedBy: String
    
}
