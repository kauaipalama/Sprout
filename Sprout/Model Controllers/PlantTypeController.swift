//
//  PlantTypeController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/18/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import Foundation
import CoreData

class PlantTypeController {
    
    //Shared Instance
    static let shared = PlantTypeController()
    
    //Properties
    var plantTypes: [PlantType] {
        let fetchRequest: NSFetchRequest<PlantType> = PlantType.fetchRequest()
        let moc = CoreDataStack.context
        do{
            return try moc.fetch(fetchRequest)
        } catch {
            print("Error fetching PlantTypes from persistent store \(error.localizedDescription)")
            return []
        }
    }
    
    //CRUD Functions
    func create(plantType type: String) {
        PlantType(type: type)
        saveToPersistantStore()
    }
    
    func update(plantType: PlantType, newTitle: String){
        plantType.type = newTitle
        saveToPersistantStore()
    }
    
    func delete(plantType: PlantType){
        let moc = plantType.managedObjectContext
        moc?.delete(plantType)
    }
    
    //Save To CoreData
    func saveToPersistantStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("Error saving to persistant store: \(error.localizedDescription)")
        }
    }
}
