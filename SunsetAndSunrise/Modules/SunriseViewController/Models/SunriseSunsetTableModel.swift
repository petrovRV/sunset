//
//  SunriseSunsetTableModel.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct SunriseSunsetTableModel {
    
    var itemList = [Item]()
    
    struct Item {
        var title = ""
        var detail = ""
    }
    
    init() {}
    
    init(with model: SunriseSunsetModel) {
        
        for i in 0..<model.count {
            itemList.append(
                Item(title: model.getTitle(with: i), detail: model[i] ?? "-")
            )
        }
        
    }
    
}
