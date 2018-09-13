//
//  LocationService.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    //MARK: - Private properties
    private let locationManager: CLLocationManager
    
    //MARK: - Public properties
    var provideCoordinates: DelegateService<CLLocationCoordinate2D>
    
    override init() {
        locationManager = CLLocationManager()
        provideCoordinates = DelegateService<CLLocationCoordinate2D>()
    }
    
    //MARK: - Private methods
    func setParameters() {
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        provideCoordinates.callback?(locValue)
        locationManager.stopUpdatingLocation()
    }
}
