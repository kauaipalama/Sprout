//
//  PlantRecord+Convenience.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/18/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//Possibly add "runoff ph" and "runoff conductivity"

import Foundation
import CoreData

extension PlantRecord {
    @discardableResult convenience init(ph: Float = 0, conductivity: Float = 0, volume: Float = 0, water_feedNotes: String? = nil, plantHealth: Int16 = 0, plantHealthNotes: String? = nil, plantImage: Data? = nil, days: Day, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.ph = ph
        self.conductivity = conductivity
        self.volume = volume
        self.water_feedNotes = water_feedNotes
        self.plantHealth = plantHealth
        self.plantHealthNotes = plantHealthNotes
        self.plantImage = plantImage
        self.days = days
    }
    
    // MOVE THIS HELPER FUCTION AND COMPUTED PROPERTIES INTO THEIR OWN FILES. Use a struct possibly.
    
    // MARK: - Helper Function
    //Helps to convert a float to a "pretty" string. Checks to see if the property is nil, if so, the function returns a not applicable string. Removes the zero at the end of whole numbers by using a Int initializer after checking if float is equal to itself rounded to the nearest whole number. If they are not equal, the statement returns a direct string interpolation of the float property.
    
    func floatAsString(float: Float) -> String {
            var floatAsString: String = ""
        if float == 0 {
            floatAsString = "N/A"
        } else if float.isEqual(to: float.rounded()) {
                floatAsString = "\(Int(float))"
                print(floatAsString)
            } else {
                floatAsString = "\(float)"
                print(floatAsString)
            }
        return floatAsString
    }
    
    // MARK: - Computed properties
    
    var conductivityString: String {
        return SproutPreferencesController.shared.conductivityUnitString + ": " + "\(floatAsString(float: conductivity))"
    }
    var volumeString: String {
        if floatAsString(float: volume) == "N/A"{
            return floatAsString(float: volume)
        } else {
            return "\(floatAsString(float: volume))" + " " + SproutPreferencesController.shared.volumeUnitString
        }
    }
    var phString: String {
        return "PH: \(floatAsString(float: ph))"
    }
    
}
