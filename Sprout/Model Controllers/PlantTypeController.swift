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

    // MARK: - CRUD
    
    func create(plantType type: String) {
        let plantType = PlantType(type: type)
        DayController.shared.createDaysForTenYearsFor(plantType: plantType)
        saveToPersistantStore()
    }
    
    func fetchDayFor(plantType: PlantType) -> Day? {
        guard let plantTypeDate = plantType.days?.array as? [Day] else {return nil}
        let today = plantTypeDate.filter { (day) -> Bool in
            let currentDate = Date()
            
            var componentSet = Set<Calendar.Component>()
            componentSet.insert(.year)
            componentSet.insert(.month)
            componentSet.insert(.day)
            
            let todaysComponents = Calendar.current.dateComponents(componentSet, from: currentDate)
            
            guard let dayDate = day.date else { return false }
            
            let dayComponents = Calendar.current.dateComponents(componentSet, from: dayDate)
            
            return todaysComponents == dayComponents
            }.first
        return today
    }
    
    func update(plantType: PlantType, newTitle: String){
        plantType.type = newTitle
        saveToPersistantStore()
    }
    
    func delete(plantType: PlantType){
        let moc = plantType.managedObjectContext
        moc?.delete(plantType)
    }
    
    // MARK: - Persistence
    
    func saveToPersistantStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("Error saving to persistant store: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Properties
    
    static let shared = PlantTypeController()
    
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
}
