//
//  HarvestedList.swift
//
//
//  Created by Timo Eichelmann on 27.01.24.
//

import Foundation
import SwiftUI

/**
 SwiftUI view displaying the harvest history list.

 This view presents a list of harvested plants along with their details.

 - Parameters:
    - props: Properties object containing information about the view.
    - selectedBed: Optional selected bed.

 - Tag: HarvestedList
 */
struct HarvestedList: View {
    // MARK: - Properties
    
    /// Managed object context environment variable.
    @Environment(\.managedObjectContext) var viewContext
    /// Properties object containing information about the view.
    var props: Properties
    /// Optional selected bed.
    var selectedBed: Bed?
    
    /// State variable to track whether the list is collapsed or expanded.
    @State var isCollapsed: Bool = false
    
    /// Fetch request to retrieve harvest history from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \HarvestHistory.date, ascending: false)],
        animation: .default)
    private var history: FetchedResults<HarvestHistory>
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("Harvest History")
                    .font(.title3.bold())
                    .padding(.bottom)
                
                // LazyVGrid for displaying the harvest history list
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: props.isAdoptable ? 20 : 15) {
                    if let bed = selectedBed {
                        // Displaying harvest history for a selected bed
                        ForEach(Array(bed.harvestHistory as? Set<HarvestHistory> ?? []).prefix(isCollapsed ? 100 : 3).sorted(by: { $0.date > $1.date })) { historyItem in
                            HStack(spacing: 15) {
                                // Icon representing the harvested plant
                                Text(historyItem.vegetable?.icon ?? "")
                                    .frame(width: 35, height: 35)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(hexString: historyItem.vegetable?.color ?? "#ffffff").opacity(0.1))
                                    }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    // Name of the harvested plant
                                    Text(historyItem.vegetable?.name ?? "")
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                    
                                    // Label displaying date and weight of the harvest
                                    Label {
                                        Text("\(historyItem.date.toString(dateFormat: "dd.MM.YYYY")) - \(historyItem.weight, specifier: "%.2f")kg")
                                            .foregroundColor(.gray)
                                    } icon: {
                                        Text(historyItem.vegetable?.name ?? "")
                                            .foregroundColor(Color(.green))
                                    }
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                }
                                .lineLimit(1)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    } else {
                        // Displaying overall harvest history
                        ForEach(history.prefix(isCollapsed ? 100 : 3).sorted(by: { $0.date > $1.date })) { historyItem in
                            HStack(spacing: 15) {
                                // Icon representing the harvested plant
                                Text(historyItem.vegetable?.icon ?? "")
                                    .frame(width: 35, height: 35)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(hexString: historyItem.vegetable?.color ?? "#ffffff").opacity(0.1))
                                    }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    // Name of the harvested plant
                                    Text(historyItem.vegetable?.name ?? "")
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                    
                                    // Label displaying date and weight of the harvest
                                    Label {
                                        Text("\(historyItem.date.toString(dateFormat: "dd.MM.YYYY")) - \(historyItem.weight, specifier: "%.2f")kg")
                                            .foregroundColor(.gray)
                                    } icon: {
                                        Text(historyItem.vegetable?.name ?? "")
                                            .foregroundColor(Color(.green))
                                    }
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                }
                                .lineLimit(1)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // Button to toggle between collapsed and expanded list view
            .overlay(alignment: .topTrailing, content: {
                Button(action: {
                    withAnimation {
                        isCollapsed.toggle()
                    }
                }, label: {
                    Text(isCollapsed ? "Show less" : "Show all")
                })
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(Color(.green))
                .offset(y: 6)
            })
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            }
            .padding(.top, 10)
        }
    }
}
