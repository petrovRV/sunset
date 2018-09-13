//
//  ViewModel.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import CoreLocation

class SunriseViewModel {
    
    //MARK: - Properties private
    private var locationManager = LocationService()
    private var sunManager = SunManager()
    
    //MARK: - Properties public
    var item = SunriseSunsetTableModel()
    var provideReloadData: (() -> ())?
    
    init() { setListener() }
    
    //MARK: - Methods private
    private func setListener() {
        
        locationManager.provideCoordinates.delegate(to: self) { (self, coordinates) in
            self.getSunriseSunsetModel(with: coordinates)
        }
        
        sunManager.provideModel.delegate(to: self) { (self, model) in
            self.item = SunriseSunsetTableModel(with: model)
            self.provideReloadData?()
        }
        
    }
    
    //MARK: - Methods public
    func getSunriseOwn() {
        locationManager.setParameters()
    }
    
    func getSunriseSunsetModel(with coordinates: CLLocationCoordinate2D) {
        sunManager.getData(with: coordinates)
    }
    
}
