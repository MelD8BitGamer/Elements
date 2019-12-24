//
//  ElementsTableViewCell.swift
//  Elements
//
//  Created by Melinda Diaz on 12/19/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import UIKit

class ElementsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var endpointURL = " http://www.theodoregray.com/periodictable/Tiles/{ElementIDWithThreeDigits}/s7.JPG"
    
    func setUpCell(eachCell: Element) {
        nameLabel.text = eachCell.name
        weightLabel.text = "\(eachCell.symbol)  (\(eachCell.number)) weight: \(String(format:"%.3f", eachCell.atomicMass))"
        //(String(format:"%.3f", (cell)) helps you limit the amount of decimal places in your double
       // imageLabel.getImages(image: "url")
    }
    
    func imageNumbers(number: Int) -> String {
        let conversion = String(number)
    }
    
}

