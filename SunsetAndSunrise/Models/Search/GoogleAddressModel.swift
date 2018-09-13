//
//  GoogleAddressModel.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/14/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct GoogleAddressModel: Codable {
    
    let status: String
    let results: [Results]
    
    struct Results: Codable {
        let geometry: Geometry
        let addressComponents: [AddressComponent]
        
        struct Geometry: Codable {
            let location: Location
            
            struct Location: Codable {
                let lat: Double
                let lng: Double
            }
        }
        
        struct AddressComponent: Codable {
            let longName: String
            let shortName: String
            let types: [String]
        }
    }
    
}
