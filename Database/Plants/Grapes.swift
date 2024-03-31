//
//  Grapes.swift
//
//
//  Created by Timo Eichelmann on 05.02.24.
//

import Foundation
import SwiftUI
import CoreData

/**
 Extension for the `Persistence` class providing a method to create a grape vegetable object.
 */
extension Persistence {
    
    /**
     Creates a grape vegetable object.
     
     - Parameter bed: The bed where the grape is planted.
     - Returns: The created grape vegetable object.
     */
    static func getGrapes(bed: Bed?) -> Vegetable {
        let grape = Vegetable(context: Persistence.shared.container.viewContext)
        grape.identifier = UUID()
        grape.name = "Grape"
        grape.latinName = "Vitis vinifera"
        grape.variety = "Grapes come in various varieties, including table grapes and wine grapes. Popular wine grape varieties include Cabernet Sauvignon, Chardonnay, and Merlot."
        grape.location = "Grapes thrive in temperate climates with well-defined seasons. They require a sunny location with good air circulation to prevent diseases. Regions with a Mediterranean climate are often ideal."
        grape.sunhours = 7
        grape.soilQuality = "Grapes prefer well-draining soil with a slightly acidic to neutral pH. Sandy-loam or loamy soils are suitable. Good drainage is crucial to prevent root diseases."
        grape.pH = 7
        grape.sowing = "Grapes are typically propagated from cuttings rather than seeds. Planting is often done in late winter or early spring when the plants are dormant."
        grape.startMonth = 4
        grape.startMonthDescription = "Direct sowing of grapes outdoors is carried out from mid-May after the Ice Saints when no more late frosts are expected. In cold frames or greenhouses grape seeds can be sown as early as April; the soil temperature should be at least 14 °C."
        grape.care = "Keep the soil consistently moist especially during fruiting. Mulching around the plants helps retain moisture and reduce weed growth."
        grape.fertilization = "Regularly fertilize grape plants with a balanced fertilizer. Follow the instructions on the fertilizer package."
        grape.deseases = "Watch for common grape pests like aphids and grape beetles. Implement organic pest control methods when necessary. Powdery mildew is a common disease; good ventilation and avoiding excessive moisture can help prevent it."
        grape.harvestMonthStart = 9
        grape.harvestMonthEnd = 11
        grape.harvestMonthDescription = "Grapes are typically harvested in late summer to early fall, depending on the variety. The optimal time to harvest is when the grapes reach their desired sweetness and color."
        grape.rotation = "While grapes are perennial plants, they don't require regular rotation. However, avoiding planting in areas where grapes or other susceptible plants were recently grown can help prevent disease buildup."
        grape.wateringDescription = "Grapes are drought-tolerant once established but require regular watering, especially during dry periods. Consistent moisture is crucial during the growing season."
        grape.wateringInterval = "One day"
        grape.winter = "Grapevines are generally hardy, but protection from severe winter conditions may be necessary in colder climates. Mulching around the base can provide insulation."
        grape.carbonFootprint = 1.5
        grape.icon = "🍇"
        grape.color = "8E1E43"
        grape.recognitionSet = ["grape"]
        grape.isDone = false
        grape.bed = bed
        
        Persistence.shared.save()
        
        return grape
    }
}
