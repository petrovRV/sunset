//
//  Constant.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/14/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

enum StoryBoard: String {
    
    case search = "Search"
    
    func getStoryBoard() -> UIStoryboard {
        switch self {
        case .search:
            return UIStoryboard.init(name: self.rawValue, bundle: Bundle.main)
        }
    }
}

enum VC: String {
    case searchVC = "SearchVC"
    
    func get() -> UIViewController {
        
        switch self {
        case .searchVC:
            return StoryBoard.getStoryBoard(.search)().instantiateViewController(withIdentifier: self.rawValue)
        }
        
    }
}

enum CellIndentifier: String {
    case itemCell = "ItemCell"
    case cell = "Cell"
}
