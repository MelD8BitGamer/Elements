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
    
    var allElements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.elementTableView.reloadData()
                //YOU MUST RELOAD DATA!!!
            }
        }
    }
    
    var userQuery = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementTableView.dataSource = self
        searchBar.delegate = self
        elementTableView.delegate = self
        setUp()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = elementTableView.indexPathForSelectedRow,
            let detailedViewController = segue.destination as? DetailViewController else { fatalError("could not prepareForSegue")}
        let eachCell = allElements[indexPath.row]
        detailedViewController.elementRef = eachCell
        
    }
    func setUp() {
        APIClient.getElements(for: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Cannot load elements \(appError)")
                }
            case .success(let data):
                self?.allElements = data
            }
        }
        addMore()
    }
    func addMore() {
        APIClient.getElements(for: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Cannot find element \(appError)")
                }
            case .success(let data):
                self?.allElements += data
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementsTableViewCell else { fatalError("Could not find Cell")}
        cell.setUpCell(eachCell: allElements[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension ViewController: UISearchBarDelegate {
//TODO: fix searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userQuery = searchText
    }

}
