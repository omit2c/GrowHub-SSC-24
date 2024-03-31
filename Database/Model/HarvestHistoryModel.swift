//
//  File.swift
//  
//
//  Created by Timo Eichelmann on 27.11.23.
//

import Foundation
import CoreData

/**
 The `HarvestHistory` class representing a managed object for harvest history entries in the application.
 */
@objc(HarvestHistory)
class HarvestHistory: NSManagedObject {
    
    /// The unique identifier of the harvest history entry.
    @NSManaged var identifier: UUID
    
    /// The date of the harvest.
    @NSManaged var date: Date
    
    /// The weight of the harvested produce.
    @NSManaged var weight: Double
    
    /// The bed associated with the harvest.
    @NSManaged var bed: Bed?
    
    /// The vegetable associated with the harvest.
    @NSManaged var vegetable: Vegetable?
}

extension HarvestHistory: Identifiable {
    
    /// The ID of the harvest history entry.
    var id: UUID {
        identifier
    }
}
