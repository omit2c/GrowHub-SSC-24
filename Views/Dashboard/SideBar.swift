//
//  SideBar.swift
//
//
//  Created by Timo Eichelmann on 27.01.24.
//

import Foundation
import SwiftUI

/**
 SwiftUI view representing the sidebar navigation.

 This view displays a sidebar with GrowHub logo and navigation tabs.

 - Parameters:
    - currentTab: Binding to the current selected tab.

 - Tag: SideBar
 */
struct SideBar: View {
    // MARK: - Properties
    
    /// Binding to the current selected tab.
    @Binding var currentTab: Tab
    
    /// Environment property to access color scheme.
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 10) {
            // GrowHub logo and title
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                
                Text("GrowHub")
                    .bold()
            }
            .padding(.bottom, 20)
            
            // Loop through all tabs to display tab icons and names
            ForEach(Tab.allCases, id: \.self) { tab in
                VStack(spacing: 8) {
                    // Tab icon
                    Image(systemName: Tab.getTabIcon(tab: tab))
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    
                    // Tab name
                    Text(tab.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(currentTab == tab ? Color(.green) : .gray)
                .padding(.vertical, 13)
                .frame(width: 65)
                .onTapGesture {
                    withAnimation(.easeInOut) { currentTab = tab }
                }
            }
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(width: 100)
        .background {
            // Set background color based on color scheme
            colorScheme == .light ? Color.white.ignoresSafeArea() : Color.black.ignoresSafeArea()
        }
    }
}
