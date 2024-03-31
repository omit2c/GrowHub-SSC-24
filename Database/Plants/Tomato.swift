//
//  File.swift
//  
//
//  Created by Timo Eichelmann on 27.11.23.
//

import Foundation
import CoreData
import SwiftUI

/**
 Extension for the `Persistence` class providing a method to create a tomato vegetable object.
 */
extension Persistence {
    
    /**
     Creates a tomato vegetable object.
     
     - Parameter bed: The bed where the tomato is planted.
     - Returns: The created tomato vegetable object.
     */
    static func getTomato(bed: Bed?) -> Vegetable {
        let tomato = Vegetable(context: Persistence.shared.container.viewContext)
        tomato.identifier = UUID()
        tomato.name = "Tomato"
        tomato.latinName = "Solanum sect. Lycopersicon"
        tomato.variety = "There are various tomato varieties, including determinate (bush) and indeterminate (vining) types, as well as different colors and sizes. Choose a variety that suits your preferences and growing conditions."
        tomato.location = "Tomatoes thrive in a sunny location with at least 6-8 hours of direct sunlight per day."
        tomato.sunhours = 8
        tomato.soilQuality = "Tomatoes prefer well-draining, fertile soil. A slightly acidic to neutral soil with a pH between 6 and 7 is ideal."
        tomato.pH = 7
        tomato.sowing = "Tomatoes can be started indoors from seeds several weeks before the last frost date and transplanted into the garden once the soil has warmed. Alternatively, you can directly sow seeds in the garden after the last frost."
        tomato.startMonth = 5
        tomato.startMonthDescription = "However, the time for planting outdoors should always be after the Ice Saints (mid-May), as tomato plants can be destroyed by night frosts. Therefore, the time for pre-breeding is not as variable as you might think. It is best to start growing tomatoes at the beginning of April."
        tomato.care = "Provide support for indeterminate varieties with stakes, cages, or trellises. Prune indeterminate types to encourage air circulation and reduce disease risk."
        tomato.fertilization = "Tomatoes benefit from regular fertilization. Use a balanced fertilizer, and follow the recommended application rates."
        tomato.deseases = "Common tomato pests include aphids, hornworms, and whiteflies. Diseases like early blight and late blight can affect tomatoes. Practice crop rotation and use organic or chemical controls when necessary."
        tomato.harvestMonthStart = 8
        tomato.harvestMonthEnd = 9
        tomato.harvestMonthDescription = "Harvest tomatoes when they reach full color and are slightly soft to the touch. Avoid leaving overripe fruits on the plant, as this can attract pests."
        tomato.rotation = "Rotate tomato plants to different areas of the garden each year to minimize the risk of soil-borne diseases."
        tomato.wateringDescription = "Tomatoes need consistent moisture, especially during flowering and fruiting. Water at the base of the plant to prevent fungal diseases. Avoid overhead watering, as wet foliage can contribute to diseases."
        tomato.wateringInterval = "One day"
        tomato.winter = "In colder regions, tomatoes are typically grown as annuals. Protect plants from frost, and consider starting seeds indoors for an early start in the spring."
        tomato.carbonFootprint = 0.8
        tomato.icon = "🍅"
        tomato.color = "ef233c"
        tomato.recognitionSet = ["tomato"]
        tomato.isDone = false
        tomato.bed = bed
        
        Persistence.shared.save()
        
        return tomato
    }
}
