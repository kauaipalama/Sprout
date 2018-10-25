//
//  PlantType+Convenience.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/18/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import Foundation
import CoreData

extension PlantType {
    @discardableResult convenience init(type: String, context: NSManagedObjectContext = CoreDataStack.context){
        
        self.init(context: context)
        self.type = type
    }
}

