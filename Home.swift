//
//  Home.swift
//  GrowHub
//
//  Created by Timo Eichelmann on 23.11.23.
//
import SwiftUI
import Charts

/// A view representing the home screen of the application.
struct Home: View {
    
    // MARK: - View Properties
    
    /// The managed object context provided by the environment.
    @Environment(\.managedObjectContext) var viewContext
    
    /// The color scheme provided by the environment.
    @Environment(\.colorScheme) var colorScheme

    /// The properties for configuring the view.
    var props: Properties
    
    /// The current tab selected.
    @State var currentTab: Tab = .home
    
    /// Namespace for animations.
    @Namespace var animation
    
    /// State variable to control the visibility of the sidebar.
    @State var showSideBar: Bool = false
    
    /// State variable to indicate if a bed is being created.
    @State var createBed: Bool = false
    
    /// State variable to indicate if a bed is being harvested.
    @State var harvestBed: Bool = false
    
    /// The currently selected bed.
    @State var selectedBed: Bed?
    
    /// Fetch request to retrieve beds.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bed.identifier, ascending: false)],
        animation: .default)
    private var beds: FetchedResults<Bed>
    
    // MARK: - Views
    
    /// The body of the view.
    var body: some View {
        HStack(spacing: 0) {
            if props.isAdoptable {
                ViewThatFits {
                    SideBar(currentTab: $currentTab)
                    ScrollView(.vertical, showsIndicators: false) {
                        SideBar(currentTab: $currentTab)
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut) { showSideBar = false }
                }
            }
            
            switch self.currentTab {
            case .home:
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        headerView
                        infoCards
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                if let bed = selectedBed {
                                    Button(action: {
                                        harvestBed.toggle()
                                    }, label: {
                                        Text("Harvest \(bed.bedName)")
                                            .foregroundStyle(Color.black)
                                            .font(.title2)
                                            .bold()
                                    })
                                    .padding(15)
                                    .frame(width: 250, height: 250)
                                    .background {
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(.green)
                                    }
                                }
                                HarvestChart(props: props, selectedBed: selectedBed)
                            }
                            .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, -15)
                        
                        HarvestedList(props: props, selectedBed: selectedBed)
                            .environment(\.managedObjectContext, viewContext)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                EnvironmentDashboard(selectedBed: $selectedBed)
                                PlantChart(selectedBed: selectedBed)
                                PlantSummary(selectedBed: selectedBed)
                            }
                            .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, -15)
                        .padding(.top, 8)
                        
                        Spacer(minLength: 100)
                    }
                    .padding(15)
                }
            case .plants:
                PlantOverView(props: props, showSideBar: self.$showSideBar)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .overlay(alignment: .leading) {
            // MARK: Side Bar For Non iPad Devices

            ViewThatFits {
                SideBar(currentTab: $currentTab)
                ScrollView(.vertical, showsIndicators: false) {
                    SideBar(currentTab: $currentTab)
                }
            }
            .offset(x: showSideBar ? 0 : -100)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                Color.black
                    .opacity(showSideBar ? 0.25 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) { showSideBar.toggle() }
                    }
            }
        }
        .sheet(isPresented: $createBed, content: {
            NavigationView {
                BedCreator()
            }
        })
        .sheet(isPresented: $harvestBed, content: {
            NavigationView {
                if let bed = selectedBed {
                    Harvest(bed: bed)
                }
            }
        })
    }
    
    
    // MARK: - Info Cards View

    /**
     Generates and displays info cards for beds.
     */
    @ViewBuilder
    var infoCards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(beds, id: \.self) { bed in
                    BedCard(bed: bed, isSelected: selectedBed == bed)
                        .onTapGesture {
                            withAnimation {
                                if let selBed = selectedBed {
                                    if selBed == bed {
                                        selectedBed = nil
                                    } else {
                                        selectedBed = bed
                                    }
                                } else {
                                    selectedBed = bed
                                }
                            }
                        }
                }
                
                Button {
                    createBed.toggle()
                } label: {
                    VStack(alignment: .center, spacing: 18) {
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: "plus")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                        }
                        .padding(20)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                }
            }
            .padding(15)
        }
        .padding(.horizontal, -15)
    }
    
    // MARK: - Header View

    /**
     Generates and displays the header view.
     */
    @ViewBuilder
    var headerView: some View {
        // MARK: Dynamic Layout(iOS 16+)

        let layout = props.isiPad && !props.isMaxSplit ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout(spacing: 22))
        
        layout {
            VStack(alignment: .leading, spacing: 8) {
                Text("Dashboard")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Search Bar With Menu Button

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
