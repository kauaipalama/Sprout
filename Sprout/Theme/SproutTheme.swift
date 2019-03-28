//
//  SproutTheme.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/5/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//Recieves call from SproutPreferences that themeString has changed and adjust var darkModeIsEnabled accordingly
import UIKit

class SproutTheme {
    
    static var current: Theme {
        if SproutPreferencesController.shared.darkModeBool == true {
            return DarkTheme()
        } else {
            return LightTheme()
        }
    }
}
