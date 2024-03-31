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
 The persistence controller for Core Data.
 */
class Persistence {
    /// The shared instance of the `Persistence` class.
    static let shared = Persistence()
    
    /// The persistent container for Core Data.
    let container: NSPersistentContainer
    
    /**
     Initializes the persistence controller.
     
     - Parameter inMemory: A boolean value indicating whether to use an in-memory store.
     */
    init(inMemory: Bool = false) {
        let container = NSPersistentContainer(name: "GrowHubModel", managedObjectModel: Persistence.createBedModel())
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed with \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        self.container = container
    }
}

