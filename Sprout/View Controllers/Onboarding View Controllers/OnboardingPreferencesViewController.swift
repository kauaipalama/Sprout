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
        nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        nextButton.tintColor = .white
        nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        
        if SproutPreferencesController.shared.darkModeBool == true {
            nextButton.layer.shadowColor = UIColor.clear.cgColor
        } else {
            nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        }
        
        guard let segmentFont = UIFont(name: "HelveticaNeue", size: 16) else {return}
        conductivitySegControl.setTitleTextAttributes([NSAttributedString.Key.font: segmentFont], for: .normal)
        volumeSegControl.setTitleTextAttributes([NSAttributedString.Key.font: segmentFont], for: .normal)
        themeSegControl.setTitleTextAttributes([NSAttributedString.Key.font: segmentFont], for: .normal)
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
