//
//  SunManager.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import CoreLocation

struct SunManager {
    
    //MARK: Private Properties
    private let baseURL = "https://api.sunrise-sunset.org/json?"
    
    //MARK: Public Properties
    var provideModel = DelegateService<SunriseSunsetModel>()
    
    //MARK: Methods
    func getData(with coordinates: CLLocationCoordinate2D) {
        let url = getUrl(with: coordinates)
        NetworkService.instance.getData(with: url, type: DefaultModel<SunriseSunsetModel>.self) { response in
            self.provideModel.callback?(response.results)
        }
    }
    
    //MARK: Private methods
    private func getUrl(with coordinates: CLLocationCoordinate2D) -> URL? {
        
        let lat = String(coordinates.latitude)
        let lng = String(coordinates.longitude)
        
        let queryItems = [
            URLQueryItem(name: Keys.lat.rawValue, value: lat),
            URLQueryItem(name: Keys.lng.rawValue, value: lng)
        ]
        
        var urlComps = URLComponents(string: baseURL)
        urlComps?.queryItems = queryItems
        return urlComps?.url
        
    }
    
}

//MARK: - Keys
extension SunManager {
    enum Keys: String {
        case lat
        case lng
    }
}
