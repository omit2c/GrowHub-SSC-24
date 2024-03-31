//
//  PlantChart.swift
//
//
//  Created by Timo Eichelmann on 27.01.24.
//

import Foundation
import SwiftUI
import Charts

/**
 SwiftUI view displaying a chart representing plant distribution.

 This view presents a chart showing the distribution of plants in a selected bed or overall.

 - Parameters:
    - selectedBed: Optional selected bed.

 - Tag: PlantChart
 */
struct PlantChart: View {
    // MARK: - Properties
    
    /// Managed object context environment variable.
    @Environment(\.managedObjectContext) var viewContext
    /// Optional selected bed.
    var selectedBed: Bed?
    
    /// Fetch request to retrieve vegetables with associated beds from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Vegetable.identifier, ascending: false)],
        predicate: NSPredicate(format: "bed != nil"),
        animation: .default)
    private var vegetables: FetchedResults<Vegetable>
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            // Chart displaying plant distribution
            Chart {
                if let bed = selectedBed {
                    let vegArray = Array(bed.vegetables as? Set<Vegetable> ?? []).filter({ $0.isDone == false })
                    let vegDic = Dictionary(grouping: vegArray) { (element: Vegetable) in
                        element.name
                    }.values.sorted {
                        return $0[0].name > $1[0].name
                    }
                    
                    // Loop through vegetable groups and display them as sectors in the chart
                    ForEach(vegDic, id: \.self) {
                        (section: [Vegetable]) in
                        SectorMark(
                            angle: .value("Vegetable", section.count),
                            innerRadius: .ratio(0.65),
                            angularInset: 2.0
                        )
                        .foregroundStyle(Color(hexString: section.first?.color ?? "#efefef"))
                        .annotation(position: .overlay) {
                            Text ("\(section.first?.icon ?? "")")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                } else {
                    let vegArray = Array(vegetables)
                    let vegDic = Dictionary(grouping: vegArray) { (element: Vegetable) in
                        element.name
                    }.values.sorted {
                        return $0[0].name > $1[0].name
                    }
                    
                    // Loop through vegetable groups and display them as sectors in the chart
                    ForEach(vegDic, id: \.self) {
                        (section: [Vegetable]) in
                        SectorMark(
                            angle: .value("Vegetable", section.count),
                            innerRadius: .ratio(0.65),
                            angularInset: 2.0
                        )
                        .foregroundStyle(Color(hexString: section.first?.color ?? "#efefef"))
                        .annotation(position: .overlay) {
                            Text ("\(section.first?.icon ?? "")")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .chartLegend(.hidden) // Hide the chart legend
        }
        .padding(15)
        .frame(width: 250, height: 250)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        }
    }
}

