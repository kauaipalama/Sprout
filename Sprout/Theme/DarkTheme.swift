//
//  DarkTheme.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/14/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

class DarkTheme: Theme {
    var preferredStatusBarStyle: UIStatusBarStyle = UIStatusBarStyle.lightContent
    
    var blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    
    var textColor: UIColor = SproutColors().darkTextColor
    
    var backgroundColor: UIColor = SproutColors().darkBackgroundColor
    
    var textFieldBackgroundColor: UIColor = SproutColors().darkTextFieldBackgroundColor
    
    var accentColor: UIColor = SproutColors().darkAccentColor
    
    var tintedTextColor: UIColor = SproutColors().darkTintedTextColor
    
    var nutrientsButtonColor: UIColor = SproutColors().darkNutrientsButtonColor
    
    var plantHealthButtonColor: UIColor = SproutColors().darkPlantHealthButtonColor
    
    var growLogButtonColor: UIColor = SproutColors().darkGrowLogButtonColor
    
    var health1Color: UIColor = SproutColors().darkHealth1Color
    
    var health2Color: UIColor = SproutColors().darkHealth2Color
    
    var health3Color: UIColor = SproutColors().darkHealth3Color
    
    var health4Color: UIColor = SproutColors().darkHealth4Color
    
    var health5Color: UIColor = SproutColors().darkHealth5Color
}
