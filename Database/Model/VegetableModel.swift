//
//  File.swift
//
//
//  Created by Timo Eichelmann on 27.11.23.
//

import CoreData
import Foundation

@objc(Vegetable)
class Vegetable: NSManagedObject {
    @NSManaged var identifier: UUID
    /// The name of the plant
    @NSManaged var name: String
    /// The latin name of the plant
    @NSManaged var latinName: String
    /// The variety of the plant
    @NSManaged var variety: String
    /// The location which is considered best for growing the plant
    @NSManaged var location: String
    /// The amount of sunlight for growing
    @NSManaged var sunhours: Int
    /// The quality of the soil
    @NSManaged var soilQuality: String
    /// The pH value for the soil
    @NSManaged var pH: Int
    /// Information about sowing the plant
    @NSManaged var sowing: String
    /// The month best for sowing
    @NSManaged var startMonth: Int
    /// Information about the best month for sowing
    @NSManaged var startMonthDescription: String
    /// Information about how to care for the plant
    @NSManaged var care: String
    /// Information about the fertilization
    @NSManaged var fertilization: String
    /// Information about pests and deseases
    @NSManaged var deseases: String
    /// The month of harvesting
    @NSManaged var harvestMonthStart: Int
    @NSManaged var harvestMonthEnd: Int
    /// Information about the month of harvesting
    @NSManaged var harvestMonthDescription: String
    /// Information about rotation
    @NSManaged var rotation: String
    /// Information about watering
    @NSManaged var wateringDescription: String
    /// Interval of watering:
    @NSManaged var wateringInterval: String
    /// Information about winter
    @NSManaged var winter: String
    /// Infromation about the Carbon footprint in kg for one kg of the plant
    @NSManaged var carbonFootprint: Double
    /// Icon for the plant
    @NSManaged var icon: String
    /// Color for the plant
    @NSManaged var color: String
    /// The bed the plant is in
    @NSManaged var bed: Bed?
    /// The watering histories the plant is in
    @NSManaged var wateringHistory: WateringHistory?
    /// The harvesting history the plant is in
    @NSManaged var harvestHistory: NSSet
    /// String recognition 
    @NSManaged var recognitionSet: [String]
    /// Determines if the plant can be used or of it is done
    @NSManaged var isDone: Bool
}

/**
 Extension for `Vegetable` class conforming to the `Identifiable` protocol.
 */
extension Vegetable: Identifiable {
    
    /// The ID of the vegetable.
    var id: UUID {
        identifier
    }

    /**
     Creates a fetch request for fetching `Vegetable` objects.
     
     - Returns: A fetch request for `Vegetable` objects.
     */
    class func createFetchRequest() -> NSFetchRequest<Vegetable> {
        return NSFetchRequest<Vegetable>(entityName: "Vegetable")
    }
}

