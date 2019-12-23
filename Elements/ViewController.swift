//
//  ViewController.swift
//  Elements
//
//  Created by Melinda Diaz on 12/19/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var elementTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allElements = [Element]()
    var userQuery = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementTableView.dataSource = self
        searchBar.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = elementTableView.indexPathForSelectedRow,
            let detailedViewController = segue.destination as? DetailViewController else { fatalError("could not prepareForSegue")}
                let eachCell = allElements[indexPath.row]
        detailedViewController.elementRef = eachCell
        
        }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementsTableViewCell else { fatalError("Could not find Cell")}
        
        //TODO: Put details in
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userQuery = searchText
    }
    
}
