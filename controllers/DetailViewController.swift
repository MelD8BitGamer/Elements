//
//  DetailViewController.swift
//  Elements
//
//  Created by Melinda Diaz on 12/19/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var elementRef: Element?
    
    @IBOutlet weak var elementImageOutlet: UIImageView!
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementWeightLabel: UILabel!
    @IBOutlet weak var elementNumberLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveredByLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        
    }
    
    @IBAction func favoritePost(_ sender: UIBarButtonItem) {
        guard var favoriteElement = elementRef else { fatalError("Bomb")
        }
        favoriteElement.favoritedBy = "MelD8BitGamer"
        APIClient.postFavorite(postElement: favoriteElement) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Denied", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Successfully!", message: "You posted this Element to your favorites")
                    sender.isEnabled = false
                }
            }
        }
    }
    
    
    func setUp() {
        guard let x = elementRef else {
            showAlert(title: "No data", message: "did not pass data on segue")
            return
        }
        let imageURL = "http://images-of-elements.com/\(x.name.lowercased()).jpg"
        
        navigationItem.title = x.name
        elementNumberLabel.text = "# \(x.number)"
        elementSymbolLabel.text = x.symbol
        
        //we have to unwrap these because they are optionals
        if let labelWeight = x.atomicMass {
            elementWeightLabel.text = "weight: \(String(format:"%.3f", labelWeight))"
        } else {
            elementWeightLabel.text = "NA"
        }
        if let labelMelt = x.melt {
            meltingPointLabel.text = "melting point: \(String(format:"%.3f",labelMelt))"
        } else {
            meltingPointLabel.text = "NA"
        }
        if let labelBoil = x.boil {
            boilingPointLabel.text = "boiling point: \(String(format:"%.3f",labelBoil))"
        } else {
            boilingPointLabel.text = "NA"
        }
        if let labelDiscover = x.discoveredBy {
            discoveredByLabel.text = "discovered by: \(labelDiscover)"
        } else {
            discoveredByLabel.text = "NA"
        }
        elementImageOutlet.getImages(image: imageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Image Error", message: "No image available \(appError)")
                    self?.elementImageOutlet.image = UIImage(named: "uhoh")
                }
            case .success(let imageURL):
                DispatchQueue.main.async {
                    self?.elementImageOutlet.image = imageURL
                }
            }
        }
        
    }
    
    
    
}




