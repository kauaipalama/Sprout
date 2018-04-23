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
    @discardableResult convenience init(date: Date, ph: Float = 0, conductivity: Float = 0, volume: Float = 0, water_feedNotes: String? = nil, plantHealth: Int16 = 0, plantHealthNotes: String? = nil, plantImage: Data? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.date = date
        self.ph = ph
        self.conductivity = conductivity
        self.volume = volume
        self.water_feedNotes = water_feedNotes
        self.plantHealth = plantHealth
        self.plantHealthNotes = plantHealthNotes
        self.plantImage = plantImage
    }
}
