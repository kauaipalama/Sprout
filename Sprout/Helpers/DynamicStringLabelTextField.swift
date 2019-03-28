//
//  DynamicStringLabelTextField.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/18/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class DynamicStringLabelTextField: UITextField {
    override func deleteBackward() {
        if text == "\(SproutPreferencesController.shared.conductivityUnitString): " || text == "\(SproutPreferencesController.shared.volumeUnitString): " || text == "PH: " {
            resignFirstResponder()
        }
        super.deleteBackward()
    }
}
