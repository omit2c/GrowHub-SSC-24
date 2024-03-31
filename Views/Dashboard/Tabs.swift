//
//  Tabs.swift
//
//
//  Created by Timo Eichelmann on 27.01.24.
//

import Foundation

/**
 Enumeration defining the available tabs in the application.

 This enum represents the different tabs available for navigation.

 - Case home: Represents the dashboard tab.
 - Case plants: Represents the plants tab.

 The enum also provides a static method to get the icon name for each tab.

 - Tag: Tab
 */
enum Tab: String, CaseIterable {
    /// Represents the dashboard tab.
    case home = "Dashboard"
    /// Represents the plants tab.
    case plants = "Plants"
    
    /**
     Gets the icon name for the specified tab.
     
     - Parameter tab: The tab for which to retrieve the icon name.
     - Returns: The icon name corresponding to the tab.
     */
    static func getTabIcon(tab: Tab) -> String {
        switch tab {
        case .home:
            return "house.fill"
        case .plants:
            return "leaf.fill"
        }
    }
}
