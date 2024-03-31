//
//  PlantsDetailView.swift
//
//
//  Created by Timo Eichelmann on 27.01.24.
//

import Foundation
import SwiftUI

/**
 View displaying detailed information about a selected plant.

 This view presents comprehensive information about the selected plant, including its name, Latin name, variety, sun hours, sowing and harvesting periods, soil quality, watering requirements, winter conditions, diseases, and carbon footprint.

 - Parameters:
    - selectedPlant: The plant for which to display detailed information.

 This view includes sections for soil, water, winter, diseases, and carbon footprint, each providing specific details about the plant's characteristics.

 - Tag: PlantsDetailView
 */
struct PlantsDetailView: View {
    // MARK: - Properties
    
    /// The selected plant for which to display detailed information.
    var selectedPlant: Vegetable
    
    /// Gradient for displaying sun hours gauge.
    let gradient = Gradient(colors: [.gray, .yellow, .orange])
    /// Gradient for displaying pH gauge.
    let gradientPH = Gradient(colors: [.red, .yellow, .orange, .green, .blue, .purple])
    /// Gradient for displaying carbon footprint gauge.
    let gradientCarbon = Gradient(colors: [.green, .red])
    
    // MARK: - Views
    
    var body: some View {
        ScrollView {
            VStack {
                // Plant Name
                Text("\(selectedPlant.icon)\(selectedPlant.name)")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.top)
                    .padding(.horizontal)
                
                // Latin Name
                Text("[\(selectedPlant.latinName)]")
                    .bold()
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                
                // Variety
                Text(selectedPlant.variety)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Sun Hours
                Text("Sunhours")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .bold()
                    .foregroundStyle(Color.secondary)
                    .padding(.horizontal)
                
                // Sun Hours Gauge
                Gauge(value: Float(selectedPlant.sunhours), in: 0...12) {
                        Text("Speed")
                    } currentValueLabel: {
                        Text(Int(selectedPlant.sunhours), format: .number)
                    } minimumValueLabel: {
                        Text("0h")
                    } maximumValueLabel: {
                        Text("12h")
                    }
                    .gaugeStyle(.accessoryLinear)
                    .tint(gradient)
                    .padding(.horizontal)
                
                // Location
                Text("\(selectedPlant.location)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Sowing Period
                Text("Sowing")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .foregroundStyle(Color.secondary)
                    .bold()
                    .padding(.horizontal)
                
                Text(DateFormatter().monthSymbols[selectedPlant.startMonth - 1])
                    .bold()
                    .font(.title2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                
                Text("\(selectedPlant.sowing)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Harvesting Period
                Text("Harvesting")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .foregroundStyle(Color.secondary)
                    .bold()
                    .padding(.horizontal)
                
                Text("\(DateFormatter().monthSymbols[selectedPlant.harvestMonthStart - 1]) - \(DateFormatter().monthSymbols[selectedPlant.harvestMonthEnd - 1])")
                    .bold()
                    .font(.title2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                
                Text("\(selectedPlant.harvestMonthDescription)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                
                // Soil Section
                soilSection
                
                // Water Section
                waterSection
                
                // Winter Section
                winterSection
                
                // Diseases Section
                deseaseSection
                
                // Carbon Section
                carbonSection
            }
        }
    }
    
    // MARK: - Soil Section
    
    private var soilSection: some View {
        Group {
            Divider()
                .padding(.horizontal)
            
            Text("Soil")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .foregroundStyle(Color.secondary)
                .bold()
                .padding(.horizontal)
            
            // pH Gauge
            Gauge(value: Float(selectedPlant.pH), in: 0...14) {
                    Text("")
                } currentValueLabel: {
                    Text(Int(selectedPlant.pH), format: .number)
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("14")
                }
                .gaugeStyle(.accessoryLinear)
                .tint(gradientPH)
                .padding(.horizontal)
            
            Text("\(selectedPlant.soilQuality)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal)
            
            Text("\(selectedPlant.fertilization)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal)
        }
    }
    
    // MARK: - Water Section
    
    private var waterSection: some View {
        Group {
            Divider()
                .padding(.horizontal)
            
            Text("Watering")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .foregroundStyle(Color.secondary)
                .bold()
                .padding(.horizontal)
            
            Text("\(selectedPlant.wateringDescription)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal)
        }
    }
    
    // MARK: - Winter Section
    
    private var winterSection: some View {
        Group {
            Divider()
                .padding(.horizontal)
            
            Text("Winter")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .foregroundStyle(Color.secondary)
                .bold()
                .padding(.horizontal)
            
            Text("\(selectedPlant.winter)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal)
        }
    }
    
    // MARK: - Diseases Section
    
    private var deseaseSection: some View {
        Group {
            Divider()
                .padding(.horizontal)
            
            Text("Diseases")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .foregroundStyle(Color.secondary)
                .bold()
                .padding(.horizontal)
            
            Text("\(selectedPlant.deseases)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal)
        }
    }
    
    // MARK: - Carbon Section
    
    private var carbonSection: some View {
        Group {
            Divider()
                .padding(.horizontal)
            
            Text("Carbon footprint")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .foregroundStyle(Color.secondary)
                .bold()
                .padding(.horizontal)
            
            // Carbon Footprint Gauge
            Gauge(value: Float(selectedPlant.carbonFootprint), in: 0...16) {
                    Text("")
                } currentValueLabel: {
                    Text(Double(selectedPlant.carbonFootprint), format: .number)
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("16")
                }
                .gaugeStyle(.accessoryCircular)
                .tint(gradientCarbon)
                .padding(.horizontal)
            
            Text("CO2 equivalents in kilograms per kilogram of food")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .foregroundStyle(Color.secondary)
                .padding(.horizontal)
        }
    }
}

