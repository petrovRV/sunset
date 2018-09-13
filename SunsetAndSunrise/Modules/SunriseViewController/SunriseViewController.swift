//
//  ViewController.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import CoreLocation

class SunriseViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var itemTable: UITableView!
    
    //MARK: - Properties
    private let model = SunriseViewModel()
    var updateSunrise = DelegateService<(coordinates: CLLocationCoordinate2D,title: String)>()

    //MARK: - VIewController Lifycycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavController()
        prepareObservers()
    }
    
    //MARK: - Methods
    private func prepareNavController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Own", style: .done, target: self, action: #selector(prepareOwn))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Other", style: .done, target: self, action: #selector(prepareOpenSearchView))
    }
    
    private func prepareObservers() {
        model.provideReloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.itemTable.reloadData()
            }
        }
        updateSunrise.delegate(to: self) { (self, res) in
            self.model.getSunriseSunsetModel(with: res.coordinates)
            self.navigationItem.title = res.title
        }
    }
    
    //MARK: - Actions
    @objc private func prepareOwn() {
        navigationItem.title = "Own"
        model.getSunriseOwn()
    }
    
    @objc private func prepareOpenSearchView() {
        let vc = VC.get(.searchVC)()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: UITableViewDataSource
extension SunriseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.item.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIndentifier.itemCell.rawValue, for: indexPath) as? SunriseSunsetTableCell else { return UITableViewCell() }
        
        cell.item = model.item.itemList[indexPath.row]
        
        return cell
        
    }
    
    
}
