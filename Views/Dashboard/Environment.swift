//
//  Environment.swift
//
//
//  Created by Timo Eichelmann on 31.01.24.
//

import Foundation
import SwiftUI

/**
 SwiftUI view representing the environment dashboard, displaying information about saved CO2 equivalent.

 - Note: Shows the total amount of CO2 equivalent saved based on harvested produce, along with equivalent distances traveled by car and plane.

 - Parameters:
    - selectedBed: Binding to the selected bed.

 - Tag: EnvironmentDashboard
 */
struct EnvironmentDashboard: View {
    // MARK: - Properties
    
    /// Binding to the selected bed.
    @Binding var selectedBed: Bed?
    /// Fetch request to retrieve beds from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bed.identifier, ascending: false)],
        animation: .default)
    private var beds: FetchedResults<Bed>
    
    // MARK: - Views
    
    var body: some View {
        environmentView
            .padding(15)
            .frame(width: 450, height: 250)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            }
    }
    
    /// A view builder for constructing the environment view.
    @ViewBuilder
    private var environmentView: some View {
        HStack(alignment: .top) {
            Image(systemName: "globe.europe.africa.fill")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundStyle(Color.accentColor.gradient)
            
            VStack(alignment: .leading) {
                Text("\(savedEnvironmentCO2(), specifier: "%.2f") kg")
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .bold()
                
                Text("Saved CO2 equivalent")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("This equivalent to")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top)
                
                Text("🚗 \(savedEnvironmentCO2() / 0.1162, specifier: "%.2f") km")
                    .contentTransition(.numericText())
                
                Text("traveled by car")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("✈️ \(savedEnvironmentCO2() / 0.230, specifier: "%.2f") km")
                    .contentTransition(.numericText())
                    .padding(.top)
                
                Text("traveled by plane")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    /**
     Calculates the total amount of CO2 equivalent saved based on harvested produce.
     
     - Returns: The total amount of CO2 equivalent saved.
     */
    private func savedEnvironmentCO2() -> Double {
        var co2: Double = 0.0
        
        if let bed = selectedBed {
            for harvest in Array(bed.harvestHistory as? Set<HarvestHistory> ?? []) {
                if let co2Eq = harvest.vegetable?.carbonFootprint {
                    co2 += (co2Eq * harvest.weight)
                }
            }
        } else {
            for bed in beds {
                for harvest in Array(bed.harvestHistory as? Set<HarvestHistory> ?? []) {
                    if let co2Eq = harvest.vegetable?.carbonFootprint {
                        co2 += (co2Eq * harvest.weight)
                    }
                }
            }
        }
        
        return co2
    }
}
