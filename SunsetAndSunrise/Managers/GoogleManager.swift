//
//  GoogleManager.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import CoreLocation

struct GoogleManager {
    
    //MARK: - Properties
    private let baseURL = "https://maps.googleapis.com/maps/api/geocode/json?"
    private let baseURL2 = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"

    private let key = "AIzaSyBTb7nSuTEq-92eugnbYVDUI7YYoZCxfnY"
    private let lang = Locale.current.languageCode ?? "uk_UA"
    private let types = "(cities)"
    
    //MARK: - Methods
    func getPlaceList(with address: String, closure: @escaping ([String])->()) {
        
        guard let addpressWithPercent = address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            print("Error: Search string not valid")
            return
        }
        
        let url = getPlaceListURL(with: addpressWithPercent)
        
        NetworkService.instance.getData(with: url, type: GoogleResponsePredictionModel.self) { response in
            closure(
                response.predictions.map { $0.description }
            )
        }
        
    }
    
    func getCoordinateByAddress(with address: String, closure: @escaping (CLLocationCoordinate2D)->()) {
        
        guard let addpressWithPercent = address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            print("Error: place not valid")
            return
        }
        
        let url = getCoordinateURL(with: addpressWithPercent)
        
        NetworkService.instance.getData(with: url, type: GoogleAddressModel.self) { response in
            guard let first = response.results.first else { return }
            
            let location = first.geometry.location
            
            let coordinate = CLLocationCoordinate2D(
                latitude: location.lat,
                longitude: location.lng
            )
            
            closure(coordinate)
            
        }
        
    }
    
    private func getPlaceListURL(with str: String) -> URL? {
        var urlComps = getURLComps(with: .listAddress)
        urlComps?.queryItems = getQueryItems(with: str, request: .listAddress)
        return urlComps?.url
    }
    
    private func getCoordinateURL(with str: String) -> URL? {
        var urlComps = getURLComps(with: .coordinates)
        urlComps?.queryItems = getQueryItems(with: str, request: .coordinates)
        return urlComps?.url
        
    }
    
    private func getQueryItems(with str: String, request: TypeRequest) -> [URLQueryItem] {
        switch request {
        case .listAddress:
            return [
                URLQueryItem(name: Keys.input.rawValue, value: str),
                URLQueryItem(name: Keys.types.rawValue, value: types),
                URLQueryItem(name: Keys.language.rawValue, value: lang),
                URLQueryItem(name: Keys.key.rawValue, value: key)
            ]
        case .coordinates:
            return [
                URLQueryItem(name: Keys.address.rawValue, value: str),
                URLQueryItem(name: Keys.key.rawValue, value: key)
            ]
        }
    }
    
    private func getURLComps(with request: TypeRequest) -> URLComponents? {
        switch request {
        case .listAddress: return URLComponents(string: baseURL2)
        case .coordinates: return URLComponents(string: baseURL)
        }
    }
    
    
}

//MARK: - Keys
extension GoogleManager {
    enum Keys: String {
        case address
        case input
        case language
        case key
        case types
    }
}

//MARK: - Keys
extension GoogleManager {
    enum TypeRequest {
        case listAddress
        case coordinates
    }
}
