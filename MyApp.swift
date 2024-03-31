import SwiftUI

/**
 The main entry point of the GrowHub application.
 */
@main
struct GrowHub: App {
    
    /// The body of the application.
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, Persistence.shared.container.viewContext)
                .onAppear {
                    // If there are no existing plants, populate with default ones.
                    let plants = Persistence.getPlants()
                    if plants.isEmpty {
                        let _ = Persistence.getTomato(bed: nil)
                        let _ = Persistence.getCucumber(bed: nil)
                        let _ = Persistence.getPineapple(bed: nil)
                        let _ = Persistence.getGrapes(bed: nil)
                        let _ = Persistence.getWatermelon(bed: nil)
                        
                        Persistence.generateExamples()
                    }
                }
        }
    }
}

