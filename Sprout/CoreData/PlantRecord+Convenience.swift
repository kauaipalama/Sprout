//
//  PlantRecord+Convenience.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/18/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import Foundation
import CoreData

extension PlantRecord {
    convenience init(ph: Float, conductivity: Float, volume: Float, water_feedNotes: String, plantHealth: Int16, plantHealthNotes: String, plantImage: Data, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.ph = ph
        self.conductivity = conductivity
        self.volume = volume
        self.water_feedNotes = water_feedNotes
        self.plantHealth = plantHealth
        self.plantHealthNotes = plantHealthNotes
        self.plantImage = plantImage
    }
}
