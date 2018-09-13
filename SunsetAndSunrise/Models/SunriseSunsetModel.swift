//
//  SunriseSunsetModel.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

fileprivate let countItems = 10

fileprivate enum Title: String {
    case sunrise = "Sunrise"
    case sunset = "Sunset"
    case solarNoon = "SolarNoon"
    case dayLength = "DayLength"
    case civilTwilightBegin = "Civil twilight begin"
    case civilTwilightEnd = "Civil twilight end"
    case nauticalTwilightBegin = "Nautical twilight begin"
    case nauticalTwilightEnd = "Nautical twilight end"
    case astronomicalTwilightBegin = "Astronomical twilight begin"
    case astronomicalTwilightEnd = "Astronomical twilight end"
}

struct SunriseSunsetModel: Decodable {
    
    var sunrise: String?
    var sunset: String?
    var solarNoon: String?
    var dayLength: String?
    var civilTwilightBegin: String?
    var civilTwilightEnd: String?
    var nauticalTwilightBegin: String?
    var nauticalTwilightEnd: String?
    var astronomicalTwilightBegin: String?
    var astronomicalTwilightEnd: String?
    
    func getTitle(with index: Int) -> String {
        switch index {
        case 0: return Title.sunrise.rawValue
        case 1: return Title.sunset.rawValue
        case 2: return Title.solarNoon.rawValue
        case 3: return Title.dayLength.rawValue
        case 4: return Title.civilTwilightBegin.rawValue
        case 5: return Title.civilTwilightEnd.rawValue
        case 6: return Title.nauticalTwilightBegin.rawValue
        case 7: return Title.nauticalTwilightEnd.rawValue
        case 8: return Title.astronomicalTwilightBegin.rawValue
        case 9: return Title.astronomicalTwilightEnd.rawValue
        default: return "-"
        }
    }
    
    var count: Int {
        return countItems
    }
    
    subscript(index: Int) -> String? {
        get {
            switch index {
            case 0: return sunrise
            case 1: return sunset
            case 2: return solarNoon
            case 3: return dayLength
            case 4: return civilTwilightBegin
            case 5: return civilTwilightEnd
            case 6: return nauticalTwilightBegin
            case 7: return nauticalTwilightEnd
            case 8: return astronomicalTwilightBegin
            case 9: return astronomicalTwilightEnd
            default: return nil
            }
        }
    }
    
}
