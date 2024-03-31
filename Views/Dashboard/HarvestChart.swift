//
//  HarvestChart.swift
//
//
//  Created by Timo Eichelmann on 27.01.24.
//

import Foundation
import SwiftUI
import Charts

/**
 SwiftUI view representing a chart displaying harvested plant data.

 This view displays a chart illustrating the harvested plant data over time.

 - Parameters:
    - props: Properties object containing information about the view.
    - selectedBed: Optional selected bed.

 - Tag: HarvestChart
 */
struct HarvestChart: View {
    // MARK: - Properties
    
    /// Managed object context environment variable.
    @Environment(\.managedObjectContext) var viewContext
    /// Properties object containing information about the view.
    var props: Properties
    /// Optional selected bed.
    var selectedBed: Bed?
    
    /// Array containing the dates for the past week.
    @State var days: [String] = [Date().toString(dateFormat: "dd.MM.YYYY")]
    /// Array containing the harvested plant data.
    @State var harvestData: [HarvestChartData] = []
    
    /// Fetch request to retrieve harvest history from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \HarvestHistory.date, ascending: false)],
        animation: .default)
    private var harvestHistory: FetchedResults<HarvestHistory>
    
    // MARK: - Views
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Harvested plants")
                .font(.title3.bold())
            
            // Chart displaying harvested plant data
            Chart {
                if let bed = selectedBed {
                    ForEach(getChartData(harvests: Array(bed.harvestHistory as? Set<HarvestHistory> ?? [])), id: \.self) { data in
                        // Area Mark for the chart
                        AreaMark(
                            x: .value("Time", data.date),
                            y: .value("Weight", data.weight)
                        )
                        .foregroundStyle(.linearGradient(colors: [
                            Color(.green).opacity(0.6),
                            Color(.green).opacity(0.5),
                            Color(.green).opacity(0.3),
                            Color(.green).opacity(0.1),
                            .clear
                        ], startPoint: .top, endPoint: .bottom))
                        .interpolationMethod(.catmullRom)
                        
                        // Line Mark for the chart
                        LineMark(
                            x: .value("Time", data.date),
                            y: .value("Weight", data.weight)
                        )
                        .foregroundStyle(Color(.green))
                        .interpolationMethod(.catmullRom)
                        
                        // Point Mark for the chart to show data points
                        PointMark(
                            x: .value("Time", data.date),
                            y: .value("Weight", data.weight)
                        )
                        .foregroundStyle(Color(.green))
                    }
                } else {
                    ForEach(getChartData(harvests: Array(harvestHistory)), id: \.self) { data in
                        // Area Mark for the chart
                        AreaMark(
                            x: .value("Time", data.date),
                            y: .value("Weight", data.weight)
                        )
                        .foregroundStyle(.linearGradient(colors: [
                            Color(.green).opacity(0.6),
                            Color(.green).opacity(0.5),
                            Color(.green).opacity(0.3),
                            Color(.green).opacity(0.1),
                            .clear
                        ], startPoint: .top, endPoint: .bottom))
                        .interpolationMethod(.catmullRom)
                        
                        // Line Mark for the chart
                        LineMark(
                            x: .value("Time", data.date),
                            y: .value("Weight", data.weight)
                        )
                        .foregroundStyle(Color(.green))
                        .interpolationMethod(.catmullRom)
                        
                        // Point Mark for the chart to show data points
                        PointMark(
                            x: .value("Time", data.date),
                            y: .value("Weight", data.weight)
                        )
                        .foregroundStyle(Color(.green))
                    }
                }
            }
        }
        .padding(15)
        .background(content: {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        })
        .frame(minWidth: props.isAdoptable ? props.size.width - 400 : props.size.width - 30)
        .frame(height: 250)
        .onAppear {
            // Populate the days array with the dates for the past week
            for i in 1..<7 {
                days.insert(Date().addingTimeInterval(-Double((86_400 * i))).toString(dateFormat: "dd.MM.YYYY"), at: 0)
            }
        }
    }
    
    /**
     Calculates the total weight of harvested plants for a specific date.
     
     - Parameters:
        - harvests: Array of harvested plant data.
        - date: The date to calculate the weight for.
     
     - Returns: The total weight of harvested plants for the specified date.
     */
    private func sumWeight(harvests: [HarvestHistory], date: String) -> Double {
        var sum: Double = 0.0
        for harvest in harvests.filter({ $0.date.toString(dateFormat: "dd.MM.YYYY") == date }) {
            sum += harvest.weight
        }
        return sum
    }
    
    /**
     Calculates the total weight of harvested plants for a specific date and bed.
     
     - Parameters:
        - harvests: Array of harvested plant data.
        - date: The date to calculate the weight for.
        - bed: The bed to calculate the weight for.
     
     - Returns: The total weight of harvested plants for the specified date and bed.
     */
    private func sumWeight(harvests: [HarvestHistory], date: String, bed: Bed) -> Double {
        var sum: Double = 0.0
        for harvest in harvests.filter({ $0.date.toString(dateFormat: "dd.MM.YYYY") == date && $0.bed?.identifier ?? UUID() == bed.identifier }) {
            sum += harvest.weight
        }
        return sum
    }
    
    /**
     Generates chart data based on harvested plant data.
     
     - Parameter harvests: Array of harvested plant data.
     
     - Returns: An array of `HarvestChartData` objects containing chart data.
     */
    private func getChartData(harvests: [HarvestHistory]) -> [HarvestChartData] {
        var data: [HarvestChartData] = []
        for day in days {
            data.append(HarvestChartData(date: day, weight: sumWeight(harvests: harvests, date: day)))
        }
        
        return data
    }
    
    /**
     Generates chart data based on harvested plant data for a specific bed.
     
     - Parameters:
        - harvests: Array of harvested plant data.
        - bed: The bed for which to generate the chart data.
     
     - Returns: An array of `HarvestChartData` objects containing chart data.
     */
    private func getChartData(harvests: [HarvestHistory], bed: Bed) -> [HarvestChartData] {
        var data: [HarvestChartData] = []
        for day in days {
            data.append(HarvestChartData(date: day, weight: sumWeight(harvests: harvests, date: day)))
        }
        
        return data
    }
}

/// Data structure representing harvested plant data.
struct HarvestChartData: Hashable {
    /// The date associated with the data.
    let date: String
    /// The weight of harvested plants for the date.
    let weight: Double
}
