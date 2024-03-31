import SwiftUI

/**
 SwiftUI view representing a card for displaying information about a bed.

 - Note: Displays bed name, number of plants, and an icon representing the first plant in the bed.

 - Parameters:
    - colorScheme: Environment variable for accessing the color scheme.
    - editBed: Boolean indicating whether the bed is being edited.
    - bed: Observed object representing the bed.
    - isSelected: Boolean indicating whether the bed is selected.

 - Tag: BedCard
 */
struct BedCard: View {
    // MARK: - Properties
    
    /// Environment variable for accessing the color scheme.
    @Environment(\.colorScheme) var colorScheme
    /// Boolean indicating whether the bed is being edited.
    @State var editBed: Bool = false
    /// Observed object representing the bed.
    @ObservedObject var bed: Bed
    /// Boolean indicating whether the bed is selected.
    var isSelected: Bool
    
    // MARK: - Views

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 15) {
                Text(bed.bedName)
                    .font(.title3.bold())
                
                Spacer()
            }
            
            HStack(spacing: 18) {
                if let veg = selectableVegetables().first {
                    Text(veg.icon)
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background {
                            Circle()
                                .fill(Color(hexString: veg.color))
                        }
                }
                
                Spacer()
                
                Text("\(selectableVegetables().count) plants")
                    .font(.title.bold())
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(isSelected ? .green : Color(.secondarySystemBackground))
        }
        .sheet(isPresented: $editBed, content: {
            NavigationView {
                BedCreator(selectedBed: bed)
            }
        })
        .contextMenu(ContextMenu(menuItems: {
            Button(role: .destructive, action: {
                Persistence.shared.container.viewContext.delete(bed)
                Persistence.shared.save()
            }, label: {
                Label(
                    title: { Text("Delete Bed") },
                    icon: { Image(systemName: "trash") }
                )
            })
            
            Button {
                editBed.toggle()
            } label: {
                Label(
                    title: { Text("Edit Bed") },
                    icon: { Image(systemName: "square.and.pencil") }
                )
            }
        }))
    }
    
    /**
     Generates a list of selectable vegetables available in the bed.
     - Returns: An array of `Vegetable` objects.
     */
    private func selectableVegetables() -> [Vegetable] {
        let vegetables = bed.vegetables
        let filteredVegetables = Array(vegetables as? Set<Vegetable> ?? []).filter({ $0.isDone == false })
        
        return filteredVegetables.sorted(by: { $0.identifier < $1.identifier })
    }
}
