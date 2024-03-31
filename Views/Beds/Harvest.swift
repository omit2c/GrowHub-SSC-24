import SwiftUI

/**
 SwiftUI view for harvesting plants from a bed.

 - Note: Allows users to select plants from a bed for harvesting, input the harvest date, and specify the harvested weight.

 - Parameters:
    - dismiss: Environment variable for dismissing the view.
    - bed: The bed from which plants are being harvested.

 - Tag: Harvest
 */
struct Harvest: View {
    // MARK: - Properties
    
    /// Environment variable for dismissing the view.
    @Environment(\.dismiss) var dismiss
    /// The bed from which plants are being harvested.
    var bed: Bed
    /// The date of the harvest.
    @State var harvestDate: Date = Date()
    /// Array of harvested vegetables.
    @State var harvestedPlants: [Vegetable] = []
    /// The currently selected plant for harvesting.
    @State var selectedPlant: Vegetable?
    /// Boolean indicating whether the plant has been harvested.
    @State var harvestPlant: Bool = false
    /// The current weight of the harvested plant.
    @State var currentWeight: Double = 0.0
    /// Boolean indicating whether the plant is done.
    @State var plantDone: Bool = false

    // MARK: - Views
    
    var body: some View {
        VStack {
            Form {
                Section {
                    DatePicker(selection: $harvestDate, displayedComponents: .date) {
                        Text("Harvest Date")
                    }
                } header: {
                    Text("Date of harvest")
                }
                .textCase(nil)

                Section {
                    ForEach(selectableVegetables(), id: \.self) { plant in
                        VStack {
                            HStack {
                                Text(plant.icon)
                                Text(plant.name)

                                Spacer()

                                Button(action: {
                                    withAnimation {
                                        if selectedPlant == plant {
                                            selectedPlant = nil
                                        } else {
                                            selectedPlant = plant
                                        }
                                    }
                                }, label: {
                                    HStack {
                                        Text("Tap to harvest")
                                        Image(systemName: "chevron.right")
                                    }
                                    .foregroundStyle(Color.accentColor.gradient)
                                })
                            }
                        }
                    }
                } header: {
                    Text("Available plants")
                } footer: {
                    Text("Select a plant you want to harvest.")
                }
                .textCase(nil)

                if let plant = selectedPlant {
                    Section {
                        VStack {
                            HStack {
                                Text(plant.icon)
                                Text(plant.name)
                                Spacer()
                            }

                            HStack {
                                TextField("Harvested weight in kg", value: $currentWeight, format: .number)
                                    .keyboardType(.numberPad)
                                Text("kg")
                            }

                            HStack {
                                Toggle(isOn: $plantDone) {
                                    Text("Plant is done")
                                }
                            }
                        }
                    } header: {
                        Text("Current plant")
                    } footer: {
                        Text("Set this plant to done, if there is no fruit left you can harvest, otherwise you can also only harvest the mature fruits.")
                    }
                    .textCase(nil)
                }
                if let plant = selectedPlant {
                     Section {
                        Button(action: {
                            harvest(plant: plant)
                        }, label: {
                            Text("Harvest \(currentWeight, specifier: "%.2f") kg of \(plant.icon)\(plant.name)")
                        })
                    }
                }

                Section {
                    if bed.harvestHistory.count == 0 {
                        Text("Nothing harvested, yet.")
                    } else {
                        harvestHistory
                    }
                } header: {
                    Text("Harvest History for \(bed.bedName)")
                } footer: {
                    Text("Total harvested amount: \(harvestedWeightSum(), specifier: "%.2f") kg")
                }
                .textCase(nil)

                Section {
                    environmentView
                } header: {
                    Text("Saved carbon dioxid")
                } footer: {
                    Text("This value is based on the amount of kg harvested of each vegetable or fruit and is only a estimated value. The real value has many factors, such as location, season and many more.")
                }
                .textCase(nil)
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle(Text("Harvest \(bed.bedName)"))
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
        })
        .onChange(of: selectedPlant) {
            if selectedPlant == nil {
                currentWeight = 0.0
                plantDone = false
            }
        }
    }

    /**
     Generates a list of selectable vegetables available for harvesting.
     - Returns: An array of `Vegetable` objects.
     */
    private func selectableVegetables() -> [Vegetable] {
        let vegetables = bed.vegetables
        let filteredVegetables = Array(vegetables as? Set<Vegetable> ?? []).filter({ $0.isDone == false })
        return filteredVegetables.sorted(by: { $0.identifier < $1.identifier })
    }

    /**
     Handles the harvesting of a plant.
     - Parameter plant: The plant being harvested.
     */
    private func harvest(plant: Vegetable) {
        let newHarvest = HarvestHistory(context: Persistence.shared.container.viewContext)
        newHarvest.identifier = UUID()
        newHarvest.vegetable = plant
        newHarvest.weight = currentWeight
        newHarvest.date = harvestDate
        newHarvest.bed = bed
        
        if plantDone {
            plant.isDone = true
        }
        
        Persistence.shared.save()
        
        selectedPlant = nil
    }

    /**
     Calculates the total harvested weight.
     - Returns: Total harvested weight.
     */
    private func harvestedWeightSum() -> Double {
        var weight: Double = 0.0
        for harvest in Array(bed.harvestHistory as? Set<HarvestHistory> ?? []) {
            weight += harvest.weight
        }
        
        return weight
    }

    /**
     Calculates the saved environmental CO2.
     - Returns: Saved environmental CO2.
     */
    private func savedEnvironmentCO2() -> Double {
        var co2: Double = 0.0
        
        for harvest in Array(bed.harvestHistory as? Set<HarvestHistory> ?? []) {
            if let co2Eq = harvest.vegetable?.carbonFootprint {
                co2 += (co2Eq * harvest.weight)
            }
        }
        
        return co2
    }

    /// View representing the harvest history.
    @ViewBuilder
    private var harvestHistory: some View {
        ForEach(Array(bed.harvestHistory as? Set<HarvestHistory> ?? []), id: \.self) { harvest in
            VStack {
                HStack {
                    Text("\(harvest.vegetable?.icon ?? "")")
                    Text("\(harvest.vegetable?.name ?? "")")
                    Spacer()
                }

                HStack {
                    Text("\(harvest.date.toString(dateFormat: "dd.MM.YYYY"))")
                        .foregroundStyle(.secondary)
                        .font(.caption)

                    Text("·")
                        .foregroundStyle(.secondary)
                        .font(.caption)

                    Text("\(harvest.weight, specifier: "%.2f") kg")
                        .foregroundStyle(.secondary)
                        .font(.caption)

                    Spacer()
                }
            }
        }
    }

    /// View representing the environmental impact.
    @ViewBuilder
    private var environmentView: some View {
        VStack(alignment: .center) {
            Image(systemName: "globe.europe.africa.fill")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundStyle(Color.accentColor.gradient)

            Text("\(savedEnvironmentCO2(), specifier: "%.2f") kg")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
