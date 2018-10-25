//
//  Day+Convenience.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/24/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import Foundation
import CoreData

extension Day {
    convenience init(date: Date, plantRecord: PlantRecord?, plantType: PlantType?, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.date = date
        self.plantRecord = plantRecord
        self.plantType = plantType
    }
}
