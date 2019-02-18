//
//  OnboardingPreferencesViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/31/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit
import Photos

class OnboardingPreferencesViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Views
    
    func setupViews() {
        //Will remove borderView from storyboard later
        setThemeColors()
        setupNextButton()
        setupSegmentedControls()
    }
    
    func setThemeColors() {
        view.backgroundColor = SproutTheme.current.backgroundColor
        conductivitySegControl.tintColor = SproutTheme.current.textColor
        volumeSegControl.tintColor = SproutTheme.current.textColor
        themeSegControl.tintColor = SproutTheme.current.textColor
        conductivityLabel.textColor = SproutTheme.current.textColor
        volumeLabel.textColor = SproutTheme.current.textColor
        themeLabel.textColor = SproutTheme.current.textColor
    }
    
    func setNavigationControllerColors() {
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
    }
    
    func setupNextButton() {
        nextButton.layer.cornerRadius = 8
        nextButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        nextButton.layer.shadowOpacity = 0.75
        nextButton.layer.borderWidth = 2
        nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        nextButton.tintColor = .white
        nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        nextButton.layer.borderColor = UIColor(red: 87.0/255.0, green: 123.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
        
        if SproutPreferencesController.shared.darkModeBool == true {
            nextButton.layer.shadowColor = UIColor.clear.cgColor
        } else {
            nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        }
    }
    
    func setupSegmentedControls() {
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
    
    // MARK: - Actions
    
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
        setNavigationControllerColors()
        setThemeColors()
        setupNextButton()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var conductivityLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var conductivitySegControl: UISegmentedControl!
    @IBOutlet weak var volumeSegControl: UISegmentedControl!
    @IBOutlet weak var themeSegControl: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
}
