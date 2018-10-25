//
//  CalendarCollectionViewCell.swift
//  CalendarWithCustomCell
//
//  Created by Kainoa Palama on 4/17/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Property
    
    var day: Day?
}
