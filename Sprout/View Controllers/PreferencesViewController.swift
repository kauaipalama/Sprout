//
//  PreferencesViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/7/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//Looks good
import UIKit

class PreferencesViewController: UIViewController {
    
    // MARK: - Life Cycle

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
    
    // MARK: - Views
    
    func setupViews() {
        view.backgroundColor = SproutTheme.current.backgroundColor
        
        unitsLabel.textColor = SproutTheme.current.textColor
        conductivityLabel.textColor = SproutTheme.current.textColor
        volumeLabel.textColor = SproutTheme.current.textColor
        themeLabel.textColor = SproutTheme.current.textColor
        conductivitySegControl.tintColor = SproutTheme.current.textColor
        volumeSegControl.tintColor = SproutTheme.current.textColor
        themeSegControl.tintColor = SproutTheme.current.textColor
        
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
        view.backgroundColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
        unitsLabel.textColor = SproutTheme.current.textColor
        conductivityLabel.textColor = SproutTheme.current.textColor
        volumeLabel.textColor = SproutTheme.current.textColor
        themeLabel.textColor = SproutTheme.current.textColor
        conductivitySegControl.tintColor = SproutTheme.current.textColor
        volumeSegControl.tintColor = SproutTheme.current.textColor
        themeSegControl.tintColor = SproutTheme.current.textColor
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var conductivityLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var conductivitySegControl: UISegmentedControl!
    @IBOutlet weak var volumeSegControl: UISegmentedControl!
    @IBOutlet weak var themeSegControl: UISegmentedControl!
    
}
