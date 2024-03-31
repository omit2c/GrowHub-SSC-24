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
 Extension for the `Persistence` class providing a method to create a pineapple vegetable object.
 */
extension Persistence {
    
    /**
     Creates a pineapple vegetable object.
     
     - Parameter bed: The bed where the pineapple is planted.
     - Returns: The created pineapple vegetable object.
     */
    static func getPineapple(bed: Bed?) -> Vegetable {
        let pineapple = Vegetable(context: Persistence.shared.container.viewContext)
        pineapple.identifier = UUID()
        pineapple.name = "Pineapple"
        pineapple.latinName = "Ananas comosus"
        pineapple.variety = "The most commonly cultivated pineapple is the \"Smooth Cayenne\" variety known for its sweet and juicy fruit. Other varieties include \"Queen Victoria\" \"Red Spanish\" and \"MD-2\" (Golden Sweet)."
        pineapple.location = "Pineapples thrive in tropical and subtropical climates. They require warm temperatures and should be grown in areas with temperatures above 60°F (15°C). Pineapples are often grown in regions like Hawaii Costa Rica the Philippines and other tropical countries."
        pineapple.sunhours = 10
        pineapple.soilQuality = "Well-draining sandy-loam soil is ideal for pineapples. They prefer slightly acidic to neutral soil with a pH ranging from 4.5 to 6.5"
        pineapple.pH = 6
        pineapple.sowing = "Pineapples are typically propagated from the crowns of mature fruits. To grow a pineapple plant remove the crown let it dry for a few days and then plant it in well-draining soil."
        pineapple.startMonth = 5
        pineapple.startMonthDescription = "The pineapple's many small flowers develop into small berries which then grow together to form a pineapple fruit. It takes between 14 and 18 months until the first fully ripe juicy pineapple is harvested and then a further 13 months until the second fruit is harvested"
        pineapple.care = "Pineapples are relatively low-maintenance. They require full sun and should be protected from strong winds. Weed control is important and mulching can help retain soil moisture."
        pineapple.fertilization = "Pineapples benefit from regular feeding with a balanced fertilizer. Apply fertilizer during the growing season and avoid high-nitrogen fertilizers."
        pineapple.deseases = "Common pests include scale insects and mealybugs. Pineapples are generally resistant to many diseases but root and heart rot can occur in waterlogged soils."
        pineapple.harvestMonthStart = 5
        pineapple.harvestMonthEnd = 6
        pineapple.harvestMonthDescription = "Pineapples are ready for harvest when the fruit develops a sweet aroma turns golden in color and can be easily plucked from the plant. Harvest the entire fruit by cutting it from the stem."
        pineapple.rotation = "Pineapples are perennial plants and a single plant can produce multiple crops. Rotate planting sites to avoid soil-borne diseases."
        pineapple.wateringDescription = "Pineapples require regular watering especially during dry periods. However they are susceptible to root rot if the soil is consistently waterlogged. Allow the soil to dry between watering."
        pineapple.wateringInterval = "One day"
        pineapple.winter = "Pineapples are sensitive to frost. In areas with cooler temperatures consider growing pineapples in containers that can be moved indoors during the winter."
        pineapple.carbonFootprint = 15.1
        pineapple.icon = "🍍"
        pineapple.color = "ffc300"
        pineapple.recognitionSet = ["pineapple"]
        pineapple.isDone = false
        pineapple.bed = bed
        
        Persistence.shared.save()
        
        return pineapple
    }
}
