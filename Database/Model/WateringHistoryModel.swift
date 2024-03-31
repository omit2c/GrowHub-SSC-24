//
//  File.swift
//  
//
//  Created by Timo Eichelmann on 27.11.23.
//

import Foundation
import CoreData

/**
 The `WateringHistory` class representing a managed object for watering history entries in the application.
 */
@objc(WateringHistory)
class WateringHistory: NSManagedObject {
    
    /// The unique identifier of the watering history entry.
    @NSManaged var identifier: UUID
    
    /// The date of the watering event.
    @NSManaged var date: Date
    
    /// The set of watering history entries.
    @NSManaged var wateringHistory: NSSet
    
    /// The vegetable associated with the watering event.
    @NSManaged var vegetable: Vegetable?
    
    /// The bed associated with the watering event.
    @NSManaged var bed: Bed?
}

extension WateringHistory: Identifiable {
    
    /// The ID of the watering history entry.
    var id: UUID {
        identifier
    }
    
    /**
     Adds plants watered to the watering history entry.
     
     - Parameter values: The set of plants watered to add.
     */
    func addPlantsWatered(values: NSSet) {
        var items = self.mutableSetValue(forKey: "wateringHistory")
        for value in values {
            items.add(value)
        }
    }
    
    /**
     Removes plants watered from the watering history entry.
     
     - Parameter values: The set of plants watered to remove.
     */
    func removePlantsWatered(values: NSSet) {
        var items = self.mutableSetValue(forKey: "wateringHistory")
        for value in values {
            items.remove(value)
        }
    }
}
