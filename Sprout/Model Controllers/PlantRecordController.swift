//
//  PlantRecordController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/18/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import Foundation
import CoreData

class PlantRecordController {

    // MARK: - CRUD
    
    func createBlankPlantRecordFor(days: Day) -> PlantRecord{
        let plantRecord = PlantRecord(days: days)
        days.plantRecord = plantRecord
        PlantTypeController.shared.saveToPersistantStore()
        return plantRecord
    }
    
    func updatePlantRecordWater_Feed(ph: Float, conductivity: Float, volume: Float, water_feedNotes: String, plantRecord: PlantRecord){
        plantRecord.ph = ph
        plantRecord.conductivity = conductivity
        plantRecord.volume = volume
        plantRecord.water_feedNotes = water_feedNotes
        PlantTypeController.shared.saveToPersistantStore()
    }
    
    func updatePlantRecordHealth(plantHealth: Int16, plantHealthNotes: String, plantImage: Data, plantRecord: PlantRecord){
        plantRecord.plantHealth = plantHealth
        plantRecord.plantHealthNotes = plantHealthNotes
        plantRecord.plantImage = plantImage
        PlantTypeController.shared.saveToPersistantStore()
    }
    
    // MARK: - Properties
    
    static let shared = PlantRecordController()
    
    var plantRecords: [PlantRecord]{
        let fetchRequest: NSFetchRequest<PlantRecord> = PlantRecord.fetchRequest()
        let moc = CoreDataStack.context
        do{
            return try moc.fetch(fetchRequest)
        } catch {
            print("Error fetching PlantTypes from persistent store \(error.localizedDescription)")
            return []
        }
    }
}
