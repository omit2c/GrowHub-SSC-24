//
//  File.swift
//  
//
//  Created by Timo Eichelmann on 27.11.23.
//

import Foundation
import SwiftUI
import CoreData

/**
 Extension for the `Persistence` class providing a method to create a cucumber vegetable object.
 */
extension Persistence {
    
    /**
     Creates a cucumber vegetable object.
     
     - Parameter bed: The bed where the cucumber is planted.
     - Returns: The created cucumber vegetable object.
     */
    static func getCucumber(bed: Bed?) -> Vegetable {
        let cucumber = Vegetable(context: Persistence.shared.container.viewContext)
        cucumber.identifier = UUID()
        cucumber.name = "Cucumber"
        cucumber.latinName = "Cucumis sativus"
        cucumber.variety = "There are different cucumber varieties including pickling cucumbers salad cucumbers and slicing cucumbers. Choose a variety that suits your preferences and local growing conditions."
        cucumber.location = "Cucumbers thrive in a sunny location with at least 6-8 hours of direct sunlight per day."
        cucumber.sunhours = 8
        cucumber.soilQuality = "Cucumbers prefer well-draining soil rich in organic matter. Aim for a slightly acidic to neutral soil with a pH between 6 and 7."
        cucumber.pH = 7
        cucumber.sowing = "Cucumbers can be started indoors early in the spring and transplanted later or seeds can be sown directly in the garden once the threat of frost has passed."
        cucumber.startMonth = 5
        cucumber.startMonthDescription = "Direct sowing of cucumbers outdoors is carried out from mid-May after the Ice Saints when no more late frosts are expected. In cold frames or greenhouses cucumber seeds can be sown as early as April; the soil temperature should be at least 14 °C."
        cucumber.care = "Keep the soil consistently moist especially during fruiting. Mulching around the plants helps retain moisture and reduce weed growth."
        cucumber.fertilization = "Regularly fertilize cucumber plants with a balanced fertilizer. Follow the instructions on the fertilizer package."
        cucumber.deseases = "Watch for common cucumber pests like aphids and cucumber beetles. Implement organic pest control methods when necessary. Powdery mildew is a common disease; good ventilation and avoiding excessive moisture can help prevent it."
        cucumber.harvestMonthStart = 6
        cucumber.harvestMonthEnd = 10
        cucumber.harvestMonthDescription = "Cucumbers can be harvested from June to October. The cucumbers can be harvested around three weeks after flowering. Around seven to ten weeks have then passed since sowing. Cucumbers should be evenly colored have smooth skin and round ends. Harvest cucumbers regularly when they are young and tender. Use sharp scissors or pruning shears to avoid damaging the plant."
        cucumber.rotation = "Avoid planting cucumbers in the same bed where they grew the previous year. Crop rotation helps minimize the risk of diseases and pests."
        cucumber.wateringDescription = "Water cucumbers consistently and check soil moisture regularly. Water in the morning to allow plants to dry before evening reducing the risk of diseases."
        cucumber.wateringInterval = "One day"
        cucumber.winter = "In regions with cold winters plant cucumbers in late spring or summer. Cucumbers are sensitive to frost so be cautious of cold temperatures."
        cucumber.carbonFootprint = 0.5
        cucumber.icon = "🥒"
        cucumber.color = "52b788"
        cucumber.recognitionSet = ["cucumber"]
        cucumber.isDone = false
        cucumber.bed = bed
        
        Persistence.shared.save()
        
        return cucumber
    }
}
