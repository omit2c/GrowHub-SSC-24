import SwiftUI

/**
 SwiftUI view for creating a new bed with associated plants.

 - Note: Allows users to input a bed name and select plants to associate with the bed.

 - Parameters:
    - dismiss: Environment variable for dismissing the view.
    - bedName: The name of the bed being created.
    - plantsToCreate: Array of `PlantCreationModel` representing the plants to be associated with the bed.
    - vegetables: Fetched results for existing vegetables.
    - selectedBed: Optional selected bed for editing.

 - Tag: BedCreator
 */
struct BedCreator: View {
    // MARK: - Properties
    
    /// Environment variable for dismissing the view.
    @Environment(\.dismiss) var dismiss
    /// The name of the bed being created.
    @State var bedName: String = ""
    /// Array of `PlantCreationModel` representing the plants to be associated with the bed.
    @State var plantsToCreate: [PlantCreationModel] = []
    /// Fetched results for existing vegetables.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Vegetable.identifier, ascending: false)],
        animation: .default)
    private var vegetables: FetchedResults<Vegetable>
    /// Optional selected bed for editing.
    var selectedBed: Bed?

    // MARK: - Views
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField(text: $bedName, prompt: Text("Enter name")) {
                        EmptyView()
                    }
                } header: {
                    Text("Name")
                }
                .textCase(nil)

                Section {
                    Button(action: {
                        plantsToCreate.append(PlantCreationModel(plantType: nil, quantity: 0))
                    }, label: {
                        Text("Add plant")
                    })

                    if !plantsToCreate.isEmpty {
                        ForEach(Array(plantsToCreate.enumerated()), id: \.element) { index, plantToCreate in
                            HStack {
                                Menu {
                                    ForEach(VegetableType.allCases, id: \.self) { plant in
                                        Button(action: {
                                            plantsToCreate[index].plantType = plant
                                        }, label: {
                                            Text(plant.rawValue)
                                        })
                                    }
                                } label: {
                                    Text("Select Plant - \(plantsToCreate[index].plantType?.rawValue ?? "")")
                                }

                                Spacer()

                                Stepper(
                                    value: Binding(get: { plantsToCreate[index].quantity }, set: { plantsToCreate[index].quantity = $0 }),
                                    in: 0...100,
                                    step: 1
                                ) {
                                    Text("Quantity: \(plantToCreate.quantity)")
                                }
                            }
                        }
                    }
                } header: {
                    Text("Current plants")
                } footer: {
                    Text("Add plants to your bed that are currently planted and growing.")
                }
                .textCase(nil)
            }

            Button(action: {
                createBed()
            }, label: {
                HStack {
                    Spacer()

                    Text("Create")
                        .bold()
                        .padding(20)
                        .foregroundStyle(Color.white)

                    Spacer()
                }
            })
            .background(Color.accentColor.ignoresSafeArea(.all))
            .padding(.top, -10)
        }
        .navigationTitle("Create Bed")
        .onAppear(perform: {
            loadBed()
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
        })
    }

    /**
     Creates a new bed or updates the selected bed with the specified plants.
     */
    private func createBed() {
        if let bed = selectedBed {
            bed.removePlant(values: bed.vegetables)

            var plantArray: [Vegetable] = []

            for plant in plantsToCreate {
                for _ in 1...plant.quantity {
                    if let p = plant.plantType {
                        switch p {
                        case .cucumber:
                            plantArray.append(Persistence.getCucumber(bed: bed))
                        case .pineapple:
                            plantArray.append(Persistence.getPineapple(bed: bed))
                        case .tomato:
                            plantArray.append(Persistence.getTomato(bed: bed))
                        case .grape:
                            plantArray.append(Persistence.getGrapes(bed: bed))
                        case .watermelon:
                            plantArray.append(Persistence.getWatermelon(bed: bed))
                        }
                    }
                }
            }

            bed.vegetables = NSSet(array: plantArray)
        } else {
            let newBed = Bed(context: Persistence.shared.container.viewContext)
            newBed.identifier = UUID()
            newBed.bedName = bedName
            newBed.created = Date()

            var plantArray: [Vegetable] = []

            for plant in plantsToCreate {
                for _ in 1...plant.quantity {
                    if let p = plant.plantType {
                        switch p {
                        case .cucumber:
                            plantArray.append(Persistence.getCucumber(bed: newBed))
                        case .pineapple:
                            plantArray.append(Persistence.getPineapple(bed: newBed))
                        case .tomato:
                            plantArray.append(Persistence.getTomato(bed: newBed))
                        case .grape:
                            plantArray.append(Persistence.getGrapes(bed: newBed))
                        case .watermelon:
                            plantArray.append(Persistence.getWatermelon(bed: newBed))
                        }
                    }
                }
            }

            newBed.vegetables = NSSet(array: plantArray)

            for plant in plantArray {
                plant.bed = newBed
            }
        }
        Persistence.shared.save()

        dismiss()
    }

    /**
     Loads existing bed data into the view for editing.
     */
    private func loadBed() {
        if let bed = selectedBed {
            let vegArray = Array(bed.vegetables as? Set<Vegetable> ?? []).filter({ !$0.isDone })
            let vegDic = Dictionary(grouping: vegArray) { (element: Vegetable) in
                element.name
            }.values.sorted {
                $0[0].name > $1[0].name
            }

            for plants in vegDic {
                switch plants.first?.name {
                case "Cucumber":
                    plantsToCreate.append(PlantCreationModel(plantType: .cucumber, quantity: plants.count))
                case "Tomato":
                    plantsToCreate.append(PlantCreationModel(plantType: .tomato, quantity: plants.count))
                case "Pineapple":
                    plantsToCreate.append(PlantCreationModel(plantType: .pineapple, quantity: plants.count))
                case "Grape":
                    plantsToCreate.append(PlantCreationModel(plantType: .grape, quantity: plants.count))
                case "Watermelon":
                    plantsToCreate.append(PlantCreationModel(plantType: .watermelon, quantity: plants.count))
                default:
                    return
                }
            }
        }
    }
}

/// Model representing a plant and its quantity for creation.
struct PlantCreationModel: Hashable {
    /// Type of vegetable for the plant.
    var plantType: VegetableType?
    /// Quantity of the plant.
    var quantity: Int
}

/// Enum representing different types of vegetables.
enum VegetableType: String, CaseIterable {
    case tomato
    case pineapple
    case cucumber
    case grape
    case watermelon
}

