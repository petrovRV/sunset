//
//  SearchViewController.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var itemTable: UITableView!
    
    //MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private let model = SearchViewModel()

    //MARK: VIewController Lifycycle
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareSC()
        prepareNI()
        prepareObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    //MARK: - Methods
    private func prepareSC() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Input place"
        definesPresentationContext = true
    }
    
    private func prepareNI() {
        
        navigationItem.title = "Search"
        
        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.searchBar
        }
        
    }
    
    private func prepareObservers() {
        
        model.provideReloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.itemTable.reloadData()
            }
        }
        
        model.provideCoordinates = { [unowned self] (coordinates, address) in
            DispatchQueue.main.async {
                
                for controller in (self.navigationController?.viewControllers)! {
                    if let vc = controller as? SunriseViewController {
                        vc.updateSunrise.callback?((coordinates, address))
                        _ = self.navigationController?.popToViewController(vc, animated: false)
                        return
                    }
                }
            }
        }
        
    }

}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIndentifier.cell.rawValue, for: indexPath)
        cell.textLabel?.text = model.itemList[indexPath.row]
        
        return cell
        
    }
    
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = model.itemList[indexPath.row]
        model.getCoordinate(with: text)
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, text != "" else {
            print("Error: search text equal nil or empty")
            return
        }
        
        model.getListPlaces(with: text)
    }
}
