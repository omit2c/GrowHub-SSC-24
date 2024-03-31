//
//  File.swift
//
//
//  Created by Timo Eichelmann on 27.11.23.
//

import CoreData
import Foundation
import SwiftUI

// MARK: - Data Model Extensions

extension Persistence {
    /**
     Creates the managed object model for the `Bed` entity and related entities.

     - Returns: The created managed object model.
     */
    static func createBedModel() -> NSManagedObjectModel {
        // Create entity description for Bed
        let bedEntity = NSEntityDescription()
        bedEntity.name = "Bed"
        bedEntity.managedObjectClassName = "Bed"

        // Create attributes for Bed entity
        let bedIDAttribute = NSAttributeDescription()
        bedIDAttribute.name = "identifier"
        bedIDAttribute.type = .uuid
        bedEntity.properties.append(bedIDAttribute)

        let bedNameAttribute = NSAttributeDescription()
        bedNameAttribute.name = "bedName"
        bedNameAttribute.type = .string
        bedEntity.properties.append(bedNameAttribute)

        let bedCreatedAttribute = NSAttributeDescription()
        bedCreatedAttribute.name = "created"
        bedCreatedAttribute.type = .date
        bedEntity.properties.append(bedCreatedAttribute)

        // Create related entities
        let wateringHistory = Persistence.createWateringHistoryModel()
        let vegetable = Persistence.createVegetableModel()
        let harvestHistory = Persistence.createHarvestHistoryModel()

        // Create model and relationships
        let model = NSManagedObjectModel()

        // Bed -> Current Plants Relation
        let bedCPRelation = NSRelationshipDescription()
        bedCPRelation.destinationEntity = bedEntity
        bedCPRelation.name = "bed"
        bedCPRelation.minCount = 0
        bedCPRelation.maxCount = 1
        bedCPRelation.isOptional = true
        bedCPRelation.deleteRule = .nullifyDeleteRule
        
        let vegetableBEDRelation = NSRelationshipDescription()
        vegetableBEDRelation.destinationEntity = vegetable
        vegetableBEDRelation.name = "vegetables"
        vegetableBEDRelation.minCount = 0
        vegetableBEDRelation.maxCount = 0
        vegetableBEDRelation.isOptional = true
        vegetableBEDRelation.deleteRule = .nullifyDeleteRule

        vegetableBEDRelation.inverseRelationship = bedCPRelation
        bedCPRelation.inverseRelationship = vegetableBEDRelation
        
        bedEntity.properties.append(vegetableBEDRelation)
        vegetable.properties.append(bedCPRelation)

        // Bed -> Watering History Relation
        let wateringHistoryRelation = NSRelationshipDescription()
        wateringHistoryRelation.destinationEntity = wateringHistory
        wateringHistoryRelation.name = "wateringHistory"
        wateringHistoryRelation.minCount = 0
        wateringHistoryRelation.maxCount = 0
        wateringHistoryRelation.isOptional = true
        wateringHistoryRelation.deleteRule = .nullifyDeleteRule
        
        let bedWHRelation = NSRelationshipDescription()
        bedWHRelation.destinationEntity = bedEntity
        bedWHRelation.name = "bed"
        bedWHRelation.minCount = 0
        bedWHRelation.maxCount = 1
        bedWHRelation.isOptional = true
        bedWHRelation.deleteRule = .nullifyDeleteRule
        
        wateringHistoryRelation.inverseRelationship = bedWHRelation
        bedWHRelation.inverseRelationship = wateringHistoryRelation

        bedEntity.properties.append(wateringHistoryRelation)
        wateringHistory.properties.append(bedWHRelation)

        // Bed -> Harvest History Relation
        let bedHHRelation = NSRelationshipDescription()
        bedHHRelation.destinationEntity = bedEntity
        bedHHRelation.name = "bed"
        bedHHRelation.minCount = 0
        bedHHRelation.maxCount = 1
        bedHHRelation.isOptional = true
        bedHHRelation.deleteRule = .nullifyDeleteRule
        
        let harvestHistoryRelation = NSRelationshipDescription()
        harvestHistoryRelation.destinationEntity = harvestHistory
        harvestHistoryRelation.name = "harvestHistory"
        harvestHistoryRelation.minCount = 0
        harvestHistoryRelation.maxCount = 0
        harvestHistoryRelation.isOptional = true
        harvestHistoryRelation.deleteRule = .nullifyDeleteRule
        
        harvestHistoryRelation.inverseRelationship = bedHHRelation
        bedHHRelation.inverseRelationship = harvestHistoryRelation

        bedEntity.properties.append(harvestHistoryRelation)
        harvestHistory.properties.append(bedHHRelation)

        // Plant -> Watering History Relation
        let vegetableWHRelation = NSRelationshipDescription()
        vegetableWHRelation.destinationEntity = vegetable
        vegetableWHRelation.name = "vegetable"
        vegetableWHRelation.minCount = 0
        vegetableWHRelation.maxCount = 1
        vegetableWHRelation.isOptional = true
        vegetableWHRelation.deleteRule = .nullifyDeleteRule
        
        let wateringHistoryPRelation = NSRelationshipDescription()
        wateringHistoryPRelation.destinationEntity = wateringHistory
        wateringHistoryPRelation.name = "wateringHistory"
        wateringHistoryPRelation.minCount = 0
        wateringHistoryPRelation.maxCount = 0
        wateringHistoryPRelation.isOptional = true
        wateringHistoryPRelation.deleteRule = .nullifyDeleteRule
        
        wateringHistoryPRelation.inverseRelationship = vegetableWHRelation
        vegetableWHRelation.inverseRelationship = wateringHistoryPRelation

        vegetable.properties.append(wateringHistoryPRelation)
        wateringHistory.properties.append(vegetableWHRelation)

        // Plant -> Harvest History Relation
        let vegetableHHRelation = NSRelationshipDescription()
        vegetableHHRelation.destinationEntity = vegetable
        vegetableHHRelation.name = "vegetable"
        vegetableHHRelation.minCount = 0
        vegetableHHRelation.maxCount = 1
        vegetableHHRelation.isOptional = true
        vegetableHHRelation.deleteRule = .nullifyDeleteRule
        
        let harvestHistoryPRelation = NSRelationshipDescription()
        harvestHistoryPRelation.destinationEntity = harvestHistory
        harvestHistoryPRelation.name = "harvestHistory"
        harvestHistoryPRelation.minCount = 0
        harvestHistoryPRelation.maxCount = 0
        harvestHistoryPRelation.isOptional = true
        harvestHistoryPRelation.deleteRule = .nullifyDeleteRule
        
        harvestHistoryPRelation.inverseRelationship = vegetableHHRelation
        vegetableHHRelation.inverseRelationship = harvestHistoryPRelation

        vegetable.properties.append(harvestHistoryPRelation)
        harvestHistory.properties.append(vegetableHHRelation)

        // Append entities to the model
        model.entities = [bedEntity, vegetable, wateringHistory, harvestHistory]

        return model
    }

    /**
     Creates the managed object model for the `WateringHistory` entity.

     - Returns: The created managed object model for watering history.
     */
    static func createWateringHistoryModel() -> NSEntityDescription {
        // Create entity description for WateringHistory
        let wateringHistoryEntity = NSEntityDescription()
        wateringHistoryEntity.name = "WateringHistory"
        wateringHistoryEntity.managedObjectClassName = "WateringHistory"

        // Define attributes for WateringHistory entity
        let wateringHistoryIDAttribute = NSAttributeDescription()
        wateringHistoryIDAttribute.name = "identifier"
        wateringHistoryIDAttribute.type = .uuid
        wateringHistoryEntity.properties.append(wateringHistoryIDAttribute)

        let wateringHistoryDateAttribute = NSAttributeDescription()
        wateringHistoryDateAttribute.name = "date"
        wateringHistoryDateAttribute.type = .date
        wateringHistoryEntity.properties.append(wateringHistoryDateAttribute)

        return wateringHistoryEntity
    }

    /**
     Creates the managed object model for the `HarvestHistory` entity.

     - Returns: The created managed object model for harvest history.
     */
    static func createHarvestHistoryModel() -> NSEntityDescription {
        // Create entity description for HarvestHistory
        let harvestHistoryEntity = NSEntityDescription()
        harvestHistoryEntity.name = "HarvestHistory"
        harvestHistoryEntity.managedObjectClassName = "HarvestHistory"

        // Define attributes for HarvestHistory entity
        let harvestHistoryIDAttribute = NSAttributeDescription()
        harvestHistoryIDAttribute.name = "identifier"
        harvestHistoryIDAttribute.type = .uuid
        harvestHistoryEntity.properties.append(harvestHistoryIDAttribute)

        let harvestHistoryDateAttribute = NSAttributeDescription()
        harvestHistoryDateAttribute.name = "date"
        harvestHistoryDateAttribute.type = .date
        harvestHistoryEntity.properties.append(harvestHistoryDateAttribute)
        
        let harvestHistoryWeightAttribute = NSAttributeDescription()
        harvestHistoryWeightAttribute.name = "weight"
        harvestHistoryWeightAttribute.type = .double
        harvestHistoryEntity.properties.append(harvestHistoryWeightAttribute)

        return harvestHistoryEntity
    }

    /**
     Creates the managed object model for the `Vegetable` entity.

     - Returns: The created managed object model for vegetables.
     */
    static func createVegetableModel() -> NSEntityDescription {
        // Create entity description for Vegetable
        let vegetableEntity = NSEntityDescription()
        vegetableEntity.name = "Vegetable"
        vegetableEntity.managedObjectClassName = "Vegetable"

        // Define attributes for Vegetable entity
        let identifierAttribute = NSAttributeDescription()
        identifierAttribute.name = "identifier"
        identifierAttribute.type = .uuid
        vegetableEntity.properties.append(identifierAttribute)

        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        vegetableEntity.properties.append(nameAttribute)

        let latinNameAttribute = NSAttributeDescription()
        latinNameAttribute.name = "latinName"
        latinNameAttribute.type = .string
        vegetableEntity.properties.append(latinNameAttribute)

        let varietyAttribute = NSAttributeDescription()
        varietyAttribute.name = "variety"
        varietyAttribute.type = .string
        vegetableEntity.properties.append(varietyAttribute)

        let locationAttribute = NSAttributeDescription()
        locationAttribute.name = "location"
        locationAttribute.type = .string
        vegetableEntity.properties.append(locationAttribute)

        let sunhoursAttribute = NSAttributeDescription()
        sunhoursAttribute.name = "sunhours"
        sunhoursAttribute.type = .integer64
        vegetableEntity.properties.append(sunhoursAttribute)

        let soilQualityAttribute = NSAttributeDescription()
        soilQualityAttribute.name = "soilQuality"
        soilQualityAttribute.type = .string
        vegetableEntity.properties.append(soilQualityAttribute)

        let pHAttribute = NSAttributeDescription()
        pHAttribute.name = "pH"
        pHAttribute.type = .integer64
        vegetableEntity.properties.append(pHAttribute)

        let sowingAttribute = NSAttributeDescription()
        sowingAttribute.name = "sowing"
        sowingAttribute.type = .string
        vegetableEntity.properties.append(sowingAttribute)

        let startMonthAttribute = NSAttributeDescription()
        startMonthAttribute.name = "startMonth"
        startMonthAttribute.type = .integer64
        vegetableEntity.properties.append(startMonthAttribute)

        let startMonthDescriptionAttribute = NSAttributeDescription()
        startMonthDescriptionAttribute.name = "startMonthDescription"
        startMonthDescriptionAttribute.type = .string
        vegetableEntity.properties.append(startMonthDescriptionAttribute)

        let careAttribute = NSAttributeDescription()
        careAttribute.name = "care"
        careAttribute.type = .string
        vegetableEntity.properties.append(careAttribute)

        let fertilizationAttribute = NSAttributeDescription()
        fertilizationAttribute.name = "fertilization"
        fertilizationAttribute.type = .string
        vegetableEntity.properties.append(fertilizationAttribute)

        let deseasesAttribute = NSAttributeDescription()
        deseasesAttribute.name = "deseases"
        deseasesAttribute.type = .string
        vegetableEntity.properties.append(deseasesAttribute)

        let harvestMonthStartAttribute = NSAttributeDescription()
        harvestMonthStartAttribute.name = "harvestMonthStart"
        harvestMonthStartAttribute.type = .integer64
        vegetableEntity.properties.append(harvestMonthStartAttribute)

        let harvestMonthEndAttribute = NSAttributeDescription()
        harvestMonthEndAttribute.name = "harvestMonthEnd"
        harvestMonthEndAttribute.type = .integer64
        vegetableEntity.properties.append(harvestMonthEndAttribute)

        let harvestMonthDescriptionAttribute = NSAttributeDescription()
        harvestMonthDescriptionAttribute.name = "harvestMonthDescription"
        harvestMonthDescriptionAttribute.type = .string
        vegetableEntity.properties.append(harvestMonthDescriptionAttribute)

        let rotationAttribute = NSAttributeDescription()
        rotationAttribute.name = "rotation"
        rotationAttribute.type = .string
        vegetableEntity.properties.append(rotationAttribute)
        
        let stringRecognitionAttribute = NSAttributeDescription()
        stringRecognitionAttribute.name = "recognitionSet"
        stringRecognitionAttribute.type = .transformable
        vegetableEntity.properties.append(stringRecognitionAttribute)

        let wateringDescriptionAttribute = NSAttributeDescription()
        wateringDescriptionAttribute.name = "wateringDescription"
        wateringDescriptionAttribute.type = .string
        vegetableEntity.properties.append(wateringDescriptionAttribute)

        let wateringIntervalAttribute = NSAttributeDescription()
        wateringIntervalAttribute.name = "wateringInterval"
        wateringIntervalAttribute.type = .string
        vegetableEntity.properties.append(wateringIntervalAttribute)

        let winterAttribute = NSAttributeDescription()
        winterAttribute.name = "winter"
        winterAttribute.type = .string
        vegetableEntity.properties.append(winterAttribute)

        let carbonFootprintAttribute = NSAttributeDescription()
        carbonFootprintAttribute.name = "carbonFootprint"
        carbonFootprintAttribute.type = .double
        vegetableEntity.properties.append(carbonFootprintAttribute)

        let iconAttribute = NSAttributeDescription()
        iconAttribute.name = "icon"
        iconAttribute.type = .string
        vegetableEntity.properties.append(iconAttribute)

        let colorAttribute = NSAttributeDescription()
        colorAttribute.name = "color"
        colorAttribute.type = .string
        vegetableEntity.properties.append(colorAttribute)
        
        let isDoneAttribute = NSAttributeDescription()
        isDoneAttribute.name = "isDone"
        isDoneAttribute.type = .boolean
        vegetableEntity.properties.append(isDoneAttribute)

        return vegetableEntity
    }

}

// MARK: - Data Model Extensions

extension Persistence {
    /// Saves changes in the managed object context if there are any changes.
    func save() {
        // Check if there are any changes in the managed object context
        if container.viewContext.hasChanges {
            do {
                // Attempt to save the changes
                try container.viewContext.save()
            } catch {
                // Print an error message if saving fails
                print("ViewContext save error: \(error)")
            }
        }
    }
}

