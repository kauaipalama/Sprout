//
//  OnboardingPreferencesViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/31/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class OnboardingPreferencesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func setupViews() {
        if SproutPreferencesController.shared.darkModeBool == true {
            borderView.backgroundColor = SproutTheme.current.textFieldBackgroundColor
            conductivitySegControl.tintColor = .black
            volumeSegControl.tintColor = .black
            themeSegControl.tintColor = .black
            unitsLabel.textColor = .black
            conductivityLabel.textColor = .black
            volumeLabel.textColor = .black
            themeLabel.textColor = .black
        } else {
            borderView.backgroundColor = SproutTheme.current.backgroundColor
            themeSegControl.tintColor = SproutTheme.current.textColor
            conductivitySegControl.tintColor = SproutTheme.current.textColor
            volumeSegControl.tintColor = SproutTheme.current.textColor
            unitsLabel.textColor = SproutTheme.current.textColor
            conductivityLabel.textColor = SproutTheme.current.textColor
            volumeLabel.textColor = SproutTheme.current.textColor
            themeLabel.textColor = SproutTheme.current.textColor
        }
        
        view.backgroundColor = SproutTheme.current.backgroundColor
        
        self.borderView.layer.borderWidth = 4
        self.borderView.layer.cornerRadius = 8
        self.borderView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.borderView.layer.shadowOpacity = 0.75
        self.borderView.layer.borderColor = SproutTheme.current.accentColor.cgColor
        self.borderView.layer.shadowColor = SproutTheme.current.accentColor.cgColor

        
        self.nextButton.layer.cornerRadius = 8
        self.nextButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.nextButton.layer.shadowOpacity = 0.75
        self.nextButton.layer.borderWidth = 4
        self.nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        self.nextButton.tintColor = .white
        self.nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        self.nextButton.layer.borderColor = UIColor(red: 87.0/255.0, green: 123.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
        
        
        switch SproutPreferencesController.shared.conductivityUnitString {
        case "EC":
            conductivitySegControl.selectedSegmentIndex = 0
        case "PPM":
            conductivitySegControl.selectedSegmentIndex = 1
        default:
            ()
        }
        
        switch SproutPreferencesController.shared.volumeUnitString {
        case "Liters":
            volumeSegControl.selectedSegmentIndex = 0
        case "Gallons":
            volumeSegControl.selectedSegmentIndex = 1
        default:
            ()
        }
        
        switch SproutPreferencesController.shared.darkModeBool {
        case true:
            themeSegControl.selectedSegmentIndex = 0
        default:
            themeSegControl.selectedSegmentIndex = 1
        }
    }
    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var conductivityLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var conductivitySegControl: UISegmentedControl!
    @IBOutlet weak var volumeSegControl: UISegmentedControl!
    @IBOutlet weak var themeSegControl: UISegmentedControl!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func conductivitySegControlTapped(_ sender: Any) {
        let index = conductivitySegControl.selectedSegmentIndex
        switch index {
        case 0:
            SproutPreferencesController.shared.conductivityUnitString = "EC"
        case 1:
            SproutPreferencesController.shared.conductivityUnitString = "PPM"
        default:
            SproutPreferencesController.shared.conductivityUnitString = "PPM"
        }
    }
    
    @IBAction func volumeSegControlTapped(_ sender: Any) {
        let index = volumeSegControl.selectedSegmentIndex
        switch index {
        case 0:
            SproutPreferencesController.shared.volumeUnitString = "Liters"
        case 1:
            SproutPreferencesController.shared.volumeUnitString = "Gallons"
        default:
            SproutPreferencesController.shared.volumeUnitString = "Gallons"
        }
        
    }
    
    @IBAction func themeSegControlTapped(_ sender: Any) {
        let index = themeSegControl.selectedSegmentIndex
        switch index {
        case 0:
            SproutPreferencesController.shared.darkModeBool = true
        case 1:
            SproutPreferencesController.shared.darkModeBool = false
        default:
            SproutPreferencesController.shared.darkModeBool = false
        }
        view.backgroundColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
        if SproutPreferencesController.shared.darkModeBool == true {
            borderView.backgroundColor = SproutTheme.current.textFieldBackgroundColor
            conductivitySegControl.tintColor = .black
            volumeSegControl.tintColor = .black
            themeSegControl.tintColor = .black
            unitsLabel.textColor = .black
            conductivityLabel.textColor = .black
            volumeLabel.textColor = .black
            themeLabel.textColor = .black
        } else {
            borderView.backgroundColor = SproutTheme.current.backgroundColor
            themeSegControl.tintColor = SproutTheme.current.textColor
            conductivitySegControl.tintColor = SproutTheme.current.textColor
            volumeSegControl.tintColor = SproutTheme.current.textColor
            unitsLabel.textColor = SproutTheme.current.textColor
            conductivityLabel.textColor = SproutTheme.current.textColor
            volumeLabel.textColor = SproutTheme.current.textColor
            themeLabel.textColor = SproutTheme.current.textColor
        }
        nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        self.borderView.layer.borderColor = SproutTheme.current.accentColor.cgColor
        self.borderView.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        setNeedsStatusBarAppearanceUpdate()
    }
}
