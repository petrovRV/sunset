//
//  SearchModel.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import CoreLocation

class SearchViewModel {
    
    //MARK: - Properties private
    private var googleManager = GoogleManager()
    
    //MARK: - Properties public
    var itemList = [String]()
    var provideReloadData: (() -> ())?
    var provideCoordinates: ((CLLocationCoordinate2D, String) -> ())?
    
    //MARK: - Methods public
    func getListPlaces(with address: String) {
        googleManager.getPlaceList(with: address) {
            self.itemList = $0
            self.provideReloadData?()
        }
    }
    
    func getCoordinate(with address: String) {
        googleManager.getCoordinateByAddress(with: address) {
            self.provideCoordinates?($0, address)
        }
    }
    
}
