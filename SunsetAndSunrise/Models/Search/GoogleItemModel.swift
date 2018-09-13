//
//  GoogleItemModel.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct GoogleResponsePredictionModel: Codable {
    
    let status: String
    let predictions: [Prediction]
    
    struct Prediction: Codable {
        let description: String
    }
    
}
