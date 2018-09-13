//
//  SunriseSunsetTableCell.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class SunriseSunsetTableCell: UITableViewCell {
    
    typealias Item = SunriseSunsetTableModel.Item
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    //MARK: Property
    var item: Item! {
        didSet {
            titleLabel.text = item.title
            detailLabel.text = item.detail
        }
    }
    
}
