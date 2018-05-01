//
//  CalendarCollectionViewCell.swift
//  CalendarWithCustomCell
//
//  Created by Kainoa Palama on 4/17/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

//protocol CalendarCollectionViewCellDelegate: class {
//    func calendarCollectionViewDidSelectView(_ cell: CalendarCollectionViewCell)
//}

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var water_feedView: UIView!
//    weak var delegate: CalendarCollectionViewCellDelegate?
    
    var day: Day? {
        didSet {
//            updateViews()
        }
    }
    
    func updateViews() {
//        delegate?.calendarCollectionViewDidSelectView(self)
//
//        switch <#value#> {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
    }
    
}
