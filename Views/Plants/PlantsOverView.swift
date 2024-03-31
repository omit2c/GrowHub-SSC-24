//
//  File.swift
//
//
//  Created by Timo Eichelmann on 23.11.23.
//

import Foundation
import SwiftUI

/**
 View displaying an overview of plants available for selection.

 This view presents an overview of plants available for selection, allowing users to tap on a plant to view detailed information.

 - Parameters:
    - showSideBar: A binding to control the visibility of the sidebar.
    - props: Properties used to configure the view's appearance and behavior.

 This view includes a header displaying location information and a search bar with a menu button for accessing additional options.

 - Tag: PlantOverView
 */
struct PlantOverView: View {
    // MARK: - Properties
    
    /// Managed object context for accessing Core Data.
    @Environment(\.managedObjectContext) var viewContext
    
    /// Fetch request to retrieve vegetables without a specified bed.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Vegetable.identifier, ascending: false)],
        predicate: NSPredicate(format: "bed == nil"),
        animation: .default)
    private var vegetables: FetchedResults<Vegetable>
    
    /// Properties used to configure the view's appearance and behavior.
    var props: Properties
    
    /// Binding to control the visibility of the sidebar.
    @Binding var showSideBar: Bool
    
    /// State variable to control the visibility of the plant detail view.
    @State var showDetailView: Bool = false
    
    /// Selected plant for displaying detailed information.
    @State var selectedPlant: Vegetable?
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            // Header View
            HeaderView()
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                    ForEach(uniqueVegies(), id: \.self) { plant in
                        Rectangle()
                            .fill(Color(hexString: plant.color).gradient)
                            .cornerRadius(10)
                            .overlay {
                                // Info Button
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(UIColor(Color(hexString: plant.color)).isDarkColor ? .white : .black)
                                    .fontWeight(.bold)
                                    .scaleEffect(1.3)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    .padding(8)
                                
                                // Plant Icon
                                Text(plant.icon)
                                    .font(.system(size: 25))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .padding(8)
                                
                                // Plant Name
                                Text(plant.name)
                                    .font(.headline)
                                    .foregroundColor(UIColor(Color(hexString: plant.color)).isDarkColor ? .white : .black)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    .bold()
                                    .padding(8)
                            }
                            .frame(height: 100, alignment: .center)
                            .onTapGesture {
                                withAnimation {
                                    self.selectedPlant = plant
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .onChange(of: self.selectedPlant, perform: { _ in
            if let plant = self.selectedPlant {
                showDetailView = true
            }
        })
        .inspector(isPresented: $showDetailView) {
            if let plant = self.selectedPlant {
                PlantsDetailView(selectedPlant: plant)
            }
        }
    }
    
    /// Filters and returns unique vegetables from the fetched results.
    private func uniqueVegies() -> [Vegetable] {
        let array = Array(vegetables)
        
        var vegies: [Vegetable] = []
        
        for plant in array {
            if !vegies.contains(where: { $0.name == plant.name }) {
                vegies.append(plant)
            }
        }
        
        return vegies
    }
    
    // MARK: Header View

    /**
     Custom header view displaying location information and search bar with menu button.

     This view presents location information and a search bar with a menu button for accessing additional options.
     */
    @ViewBuilder
    func HeaderView() -> some View {
        // Dynamic Layout(iOS 16+)
        let layout = props.isiPad && !props.isMaxSplit ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout(spacing: 22))
        
        layout {
            // Location Information
            VStack(alignment: .leading, spacing: 8) {
                Text("Plants")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Search Bar With Menu Button
            HStack(spacing: 10) {
                if !props.isAdoptable {
                    Button {
                        withAnimation(.easeInOut) { showSideBar.toggle() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .background {
                        Capsule()
                            .fill(.white)
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
}

