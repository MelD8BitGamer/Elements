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
                    }
                    break
                }
            }
        }
    

    
    func uploadDat() {
     
            }
}
    


