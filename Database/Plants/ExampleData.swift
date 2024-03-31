//
//  Example Data.swift
//
//
//  Created by Timo Eichelmann on 20.02.24.
//

import Foundation
import SwiftUI
import CoreData

extension Persistence {
    static func generateExamples() {
        // Generate beds
        let bed1 = Bed(context: self.shared.container.viewContext)
        bed1.identifier = UUID()
        bed1.bedName = "Front garden"
        bed1.created = Date()
        
        let bed2 = Bed(context: self.shared.container.viewContext)
        bed2.identifier = UUID()
        bed2.bedName = "Back garden"
        bed2.created = Date()
        
        var plantArray1: [Vegetable] = []
        var plantArray2: [Vegetable] = []
        
        // Generate plants
        for i in 0..<Int.random(in: 1..<5) {
            plantArray1.append(Persistence.getCucumber(bed: bed1))
        }
        for i in 0..<Int.random(in: 1..<6) {
            plantArray1.append(Persistence.getTomato(bed: bed1))
        }
        for i in 0..<Int.random(in: 1..<2) {
            plantArray1.append(Persistence.getGrapes(bed: bed1))
        }
        for i in 0..<Int.random(in: 1..<8) {
            plantArray1.append(Persistence.getWatermelon(bed: bed1))
        }
        bed1.vegetables = NSSet(array: plantArray1)
        for plant in plantArray1 {
            plant.bed = bed1
        }
        
        for i in 0..<Int.random(in: 1..<5) {
            plantArray2.append(Persistence.getPineapple(bed: bed2))
        }
        for i in 0..<Int.random(in: 1..<6) {
            plantArray2.append(Persistence.getTomato(bed: bed2))
        }
        for i in 0..<Int.random(in: 1..<2) {
            plantArray2.append(Persistence.getGrapes(bed: bed2))
        }
        for i in 0..<Int.random(in: 1..<8) {
            plantArray2.append(Persistence.getCucumber(bed: bed2))
        }
        bed2.vegetables = NSSet(array: plantArray2)
        for plant in plantArray2 {
            plant.bed = bed2
        }
        
        // Generate harvests
        let harvest1 = HarvestHistory(context: Persistence.shared.container.viewContext)
        harvest1.identifier = UUID()
        harvest1.vegetable = Array(bed1.vegetables as? Set<Vegetable> ?? []).first
        harvest1.weight = Double.random(in: 1..<8)
        harvest1.date = Date()
        harvest1.bed = bed1
        
        let harvest2 = HarvestHistory(context: Persistence.shared.container.viewContext)
        harvest2.identifier = UUID()
        harvest2.vegetable = Array(bed1.vegetables as? Set<Vegetable> ?? []).last
        harvest2.weight = Double.random(in: 1..<8)
        harvest2.date = Date()
        harvest2.bed = bed1
        
        let harvest3 = HarvestHistory(context: Persistence.shared.container.viewContext)
        harvest3.identifier = UUID()
        harvest3.vegetable = Array(bed2.vegetables as? Set<Vegetable> ?? []).first
        harvest3.weight = Double.random(in: 1..<8)
        harvest3.date = Date()
        harvest3.bed = bed2
        
        let harvest4 = HarvestHistory(context: Persistence.shared.container.viewContext)
        harvest4.identifier = UUID()
        harvest4.vegetable = Array(bed2.vegetables as? Set<Vegetable> ?? []).last
        harvest4.weight = Double.random(in: 1..<8)
        harvest4.date = Date()
        harvest4.bed = bed2
        
        
        self.shared.save()
    }
}
