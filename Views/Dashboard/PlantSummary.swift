import SwiftUI
/**
 SwiftUI view presenting a summary of plants.

 This view displays a summary of plants, showing the count of each type of plant.

 - Parameters:
    - selectedBed: Optional selected bed.

 - Tag: PlantSummary
 */
struct PlantSummary: View {
    
    // MARK: - Properties
    
    /// Optional selected bed.
    var selectedBed: Bed?
    
    /// Fetch request to retrieve vegetables with associated beds from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Vegetable.identifier, ascending: false)],
        predicate: NSPredicate(format: "bed != nil && isDone == false"),
        animation: .default)
    private var vegetables: FetchedResults<Vegetable>
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            // Title displaying "Your plants"
            Text("Your plants")
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            // LazyVGrid displaying plant icons and counts
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 75)), count: 4)) {
                if let bed = selectedBed {
                    let vegArray = Array(bed.vegetables as? Set<Vegetable> ?? []).filter { $0.isDone == false }
                    let vegDic = Dictionary(grouping: vegArray) { (element: Vegetable) in
                        element.name
                    }.values.sorted {
                        $0[0].name > $1[0].name
                    }
                    
                    // Loop through vegetable groups and display icons and counts
                    ForEach(vegDic, id: \.self) {
                        (section: [Vegetable]) in
                        HStack {
                            // Plant icon
                            Text(section[0].icon)
                                .font(.largeTitle)
                            // Plant count
                            Text("\(section.count)")
                                .font(.largeTitle)
                                .bold()
                                .contentTransition(.numericText())
                        }
                    }
                } else {
                    let vegArray = Array(vegetables)
                    let vegDic = Dictionary(grouping: vegArray) { (element: Vegetable) in
                        element.name
                    }.values.sorted {
                        $0[0].name > $1[0].name
                    }
                    
                    // Loop through vegetable groups and display icons and counts
                    ForEach(vegDic, id: \.self) {
                        (section: [Vegetable]) in
                        HStack {
                            // Plant icon
                            Text(section[0].icon)
                                .font(.largeTitle)
                            // Plant count
                            Text("\(section.count)")
                                .font(.largeTitle)
                                .bold()
                                .contentTransition(.numericText())
                        }
                    }
                }
            }
            
            Spacer()
        }
        .frame(width: 310, height: 250)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        }
    }
}
