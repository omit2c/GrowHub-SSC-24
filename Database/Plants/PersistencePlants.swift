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
 Extension for the `Persistence` class providing a method to fetch all plants.
 */
extension Persistence {
    
    /**
     Fetches all plants from the persistent store.
     
     - Returns: An array of vegetable objects representing the fetched plants.
     */
    static func getPlants() -> [Vegetable] {
        let fetchRequest: NSFetchRequest<Vegetable> = Vegetable.createFetchRequest()

        do {
            let plants = try Persistence.shared.container.viewContext.fetch(fetchRequest)
            return plants
        } catch {
            print("Error fetching plants: \(error)")
            return []
        }
    }
}
