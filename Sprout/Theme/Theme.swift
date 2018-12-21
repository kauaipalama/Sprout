//
//  Theme.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/14/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

protocol Theme {
    var preferredStatusBarStyle: UIStatusBarStyle {get}
    var blurEffect: UIBlurEffect {get}
    var textColor: UIColor {get}
    var backgroundColor: UIColor {get}
    var accentColor: UIColor {get}
    var tintedTextColor: UIColor {get}
    var nutrientsButtonColor: UIColor {get}
    var plantHealthButtonColor: UIColor {get}
    var growLogButtonColor: UIColor {get}
    var health1Color: UIColor {get}
    var health2Color: UIColor {get}
    var health3Color: UIColor {get}
    var health4Color: UIColor {get}
    var health5Color: UIColor {get}
}
