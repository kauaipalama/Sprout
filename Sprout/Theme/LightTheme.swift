//
//  LightTheme.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/14/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

class LightTheme: Theme {
    var preferredStatusBarStyle: UIStatusBarStyle = UIStatusBarStyle.default
    
    var blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
    
    var textColor: UIColor = SproutColors().lightTextColor
    
    var backgroundColor: UIColor = SproutColors().lightBackgroundColor
    
    var textFieldBackgroundColor: UIColor = SproutColors().lightTextFieldBackgroundColor
    
    var accentColor: UIColor = SproutColors().lightAccentColor
    
    var tintedTextColor: UIColor = SproutColors().lightTintedTextColor
    
    var nutrientsButtonColor: UIColor = SproutColors().lightNutrientsButtonColor
    
    var plantHealthButtonColor: UIColor = SproutColors().lightPlantHealthButtonColor
    
    var growLogButtonColor: UIColor = SproutColors().lightGrowLogButtonColor
    
    var health1Color: UIColor = SproutColors().lightHealth1Color
    
    var health2Color: UIColor = SproutColors().lightHealth2Color
    
    var health3Color: UIColor = SproutColors().lightHealth3Color
    
    var health4Color: UIColor = SproutColors().lightHealth4Color
    
    var health5Color: UIColor = SproutColors().lightHealth5Color
}
