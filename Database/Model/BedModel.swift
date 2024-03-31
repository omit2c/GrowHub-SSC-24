//
//  File.swift
//  
//
//  Created by Timo Eichelmann on 27.11.23.
//

import Foundation
import CoreData

/**
 The `Bed` class representing a managed object for beds in the application.
 */
@objc(Bed)
class Bed: NSManagedObject {
    
    /// The unique identifier of the bed.
    @NSManaged var identifier: UUID
    
    /// The name of the bed.
    @NSManaged var bedName: String
    
    /// The creation date of the bed.
    @NSManaged var created: Date
    
    /// The set of vegetables associated with the bed.
    @NSManaged var vegetables: NSSet
    
    /// The set of watering history associated with the bed.
    @NSManaged var wateringHistory: NSSet
    
    /// The set of harvest history associated with the bed.
    @NSManaged var harvestHistory: NSSet
}

extension Bed: Identifiable {
    
    /// The ID of the bed.
    var id: UUID {
        identifier
    }
    
    /**
     Adds plants to the bed.
     
     - Parameter values: The set of plants to add.
     */
    func addPlant(values: NSSet) {
        var items = self.mutableSetValue(forKey: "vegetables")
        for value in values {
            items.add(value)
        }
    }
    
    /**
     Removes plants from the bed.
     
     - Parameter values: The set of plants to remove.
     */
    func removePlant(values: NSSet) {
        var items = self.mutableSetValue(forKey: "vegetables")
        for value in values {
            items.remove(value)
        }
    }
    
    /**
     Adds watering history to the bed.
     
     - Parameter values: The set of watering history entries to add.
     */
    func addWatering(values: NSSet) {
        var items = self.mutableSetValue(forKey: "wateringHistory")
        for value in values {
            items.add(value)
        }
    }
    
    /**
     Removes watering history from the bed.
     
     - Parameter values: The set of watering history entries to remove.
     */
    func removeWatering(values: NSSet) {
        var items = self.mutableSetValue(forKey: "wateringHistory")
        for value in values {
            items.remove(value)
        }
    }
    
    /**
     Adds plant harvest history to the bed.
     
     - Parameter values: The set of plant harvest history entries to add.
     */
    func addPlantHistory(values: NSSet) {
        var items = self.mutableSetValue(forKey: "harvestHistory")
        for value in values {
            items.add(value)
        }
    }
    
    /**
     Removes plant harvest history from the bed.
     
     - Parameter values: The set of plant harvest history entries to remove.
     */
    func removePlantHistory(values: NSSet) {
        var items = self.mutableSetValue(forKey: "harvestHistory")
        for value in values {
            items.remove(value)
        }
    }
}
