import SwiftUI

/// A view struct representing the content of the application.
struct ContentView: View {
    
    // MARK: - Properties
    
    /// The managed object context provided by the environment.
    @Environment(\.managedObjectContext) var viewContext
    
    // MARK: - Body
    
    var body: some View {
        ResponsiveView { props in
            Home(props: props)
                .environment(\.managedObjectContext, self.viewContext)
        }
    }
}
