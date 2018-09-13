//
//  DefaultModel.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct DefaultModel<Result: Decodable>: Decodable {
    var results: Result
    var status: String
}
