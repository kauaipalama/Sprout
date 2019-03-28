//
//  SproutPreferencesController.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/10/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//Make the call to SproutTheme when themeString changes.

import Foundation

class SproutPreferencesController {
    
    
    // MARK: - Initializer
    
    init() {
        loadFromUserDefaults()
    }
    
    // MARK: - Persistance
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "sprout.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    func saveToUserDefaults() {
        defaults.set([conductivityUnitString, volumeUnitString], forKey: "UnitPreferences")
        defaults.set(darkModeBool, forKey: "ThemePreference")
    }
    
    func loadFromUserDefaults() {
        let unitPreferences = defaults.object(forKey: "UnitPreferences") as? [String] ?? defaultPreferences
        let themePreference = defaults.object(forKey: "ThemePreference") as? Bool ?? defaultDarkModeBool
        self.conductivityUnitString = unitPreferences[0]
        self.volumeUnitString = unitPreferences[1]
        self.darkModeBool = themePreference
    }
    
    
    // MARK: - Properties
    
    static let shared = SproutPreferencesController()
    let defaults = UserDefaults.standard
    let defaultPreferences = ["PPM", "Gallons"]
    let defaultDarkModeBool = false
    
    var conductivityUnitString: String = "PPM" {
        didSet {
            saveToUserDefaults()
        }
    }
    
    var volumeUnitString: String = "Gallons" {
        didSet {
            saveToUserDefaults()
        }
    }
    
    var darkModeBool: Bool = false {
        didSet {
            saveToUserDefaults()
        }
    }
}
