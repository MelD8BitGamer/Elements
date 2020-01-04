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
    
    
    
    
    func setUpCell(eachCell: Element) {
        nameLabel.text = eachCell.name
        weightLabel.text = "\(eachCell.symbol)  (\(eachCell.number)) weight: \(String(format:"%.3f", eachCell.atomicMass ?? 0.0 ))"
        //(String(format:"%.3f", (cell)) helps you limit the amount of decimal places in your double
        imageLabel.getImages(image: imageNumbers(number: eachCell.number)) { [weak self] (result) in
            switch result{
            case .failure(let appError):
                fatalError("Could not get image \(appError)")
            case.success(let elementImages):
                DispatchQueue.main.async {
                    self?.imageLabel.image = elementImages
                }
            }
            
        }
        
    }
    
    func imageNumbers(number: Int) -> String {
        var conversion = String(number)
        //while loops loops through until conditions are false
        while conversion.count < 3 {
            conversion.insert("0", at: conversion.startIndex)
        }
        return "http://www.theodoregray.com/periodictable/Tiles/\(conversion)/s7.JPG"
    }
    
    
}

