//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Melinda Diaz on 12/26/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var myElementRef = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        setUp()
        
    }
    
    func setUp() {
        APIClient.getElements(for: "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Favorites Error", message: "Unable to retrieve favorites \(appError)")
                }
            case .success(let data):
                self?.myElementRef = data.filter{$0.favoritedBy == "MelD8BitGamer"}
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = favoriteTableView.indexPathForSelectedRow,
            let detailView = segue.destination as? DetailViewController else { fatalError("Could not segue from favorites")
        }
        let eachCell = myElementRef[indexPath.row]
        detailView.elementRef = eachCell
        detailView.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myElementRef.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? ElementsTableViewCell else {
            fatalError("Could not load favorites")
        }
        cell.setUpCell(eachCell: myElementRef[indexPath.row])
        return cell
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
}
