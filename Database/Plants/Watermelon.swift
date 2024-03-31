//
//  Watermelon.swift
//
//
//  Created by Timo Eichelmann on 05.02.24.
//

import Foundation
import SwiftUI
import CoreData

/**
 Extension for the `Persistence` class providing a method to create a watermelon vegetable object.
 */
extension Persistence {
    
    /**
     Creates a watermelon vegetable object.
     
     - Parameter bed: The bed where the watermelon is planted.
     - Returns: The created watermelon vegetable object.
     */
    static func getWatermelon(bed: Bed?) -> Vegetable {
        let watermelon = Vegetable(context: Persistence.shared.container.viewContext)
        watermelon.identifier = UUID()
        watermelon.name = "Watermelon"
        watermelon.latinName = "Citrullus lanatus"
        watermelon.variety = "Watermelons come in various varieties, including seedless and seeded. Popular varieties include Crimson Sweet, Sugar Baby, and Jubilee."
        watermelon.location = "Watermelons thrive in warm climates with plenty of sunlight. They require well-drained soil and benefit from raised beds. Adequate spacing between plants is essential for proper growth."
        watermelon.sunhours = 8
        watermelon.soilQuality = "Watermelons prefer sandy loam or loamy soil with a slightly acidic to neutral pH. Good drainage is crucial to prevent waterlogging and root diseases."
        watermelon.pH = 6
        watermelon.sowing = "Watermelons are usually grown from seeds. Plant seeds directly in the garden or start them indoors in biodegradable pots before transplanting. Plant when the soil temperature is consistently above 60°F (15°C)."
        watermelon.startMonth = 5
        watermelon.startMonthDescription = "Watermelon seeds can be sown outdoors after the last frost when the soil has warmed up. In colder climates, starting seeds indoors and transplanting after the last frost is common."
        watermelon.care = "Provide consistent watering, especially during dry spells. Mulching around the plants helps retain soil moisture and suppress weeds."
        watermelon.fertilization = "Fertilize watermelon plants with a balanced fertilizer. Follow a feeding schedule, especially during the flowering and fruiting stages."
        watermelon.deseases = "Watch for common watermelon pests like aphids and cucumber beetles. Implement pest control measures as needed. Powdery mildew and fungal diseases can be prevented with proper spacing and airflow."
        watermelon.harvestMonthStart = 7
        watermelon.harvestMonthEnd = 9
        watermelon.harvestMonthDescription = "Watermelons are typically ready for harvest in mid to late summer, depending on the variety. Harvest when the bottom of the fruit turns yellow, and the tendrils near the stem dry up."
        watermelon.rotation = "Watermelons are annual plants, so rotating crops is essential to prevent soil-borne diseases. Avoid planting watermelons in the same spot consecutively."
        watermelon.wateringDescription = "Watermelons need consistent watering, especially during the flowering and fruiting stages. Keep the soil consistently moist but not waterlogged."
        watermelon.wateringInterval = "Every 2-3 days"
        watermelon.winter = "Watermelons are sensitive to frost and cannot tolerate cold temperatures. Harvest before the first frost, and protect young plants from late spring frosts."
        watermelon.carbonFootprint = 2.0
        watermelon.icon = "🍉"
        watermelon.color = "118F24"
        watermelon.recognitionSet = ["watermelon"]
        watermelon.isDone = false
        watermelon.bed = bed
        
        Persistence.shared.save()
        
        return watermelon
    }

}
