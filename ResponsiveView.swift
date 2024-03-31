//
//  ResponsiveView.swift
//  GrowHub
//
//  Created by Timo Eichelmann on 23.11.23.
//

import Foundation
import SwiftUI

/**
 A custom view providing properties for adaptable UI.
 */
struct ResponsiveView<Content: View>: View {
    
    /// The content of the view.
    var content: (Properties) -> Content
    
    /**
     Initializes a new instance of the ResponsiveView.
     
     - Parameter content: The content to display within the view.
     */
    init(@ViewBuilder content: @escaping (Properties) -> Content) {
        self.content = content
    }
    
    /// The body of the view.
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let isLandscape = size.width > size.height
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let isMaxSplit = isSplit() && size.width < 400
            
            // MARK: In Vertical Hiding Side Bar Completely
            // In Horizontal Showing Side bar for 0.75 Fraction
            
            let isAdoptable = isIpad && (isLandscape ? !isMaxSplit : !isSplit())
            let properties = Properties(isLandscape: isLandscape, isiPad: isIpad, isSplit: isSplit(), isMaxSplit: isMaxSplit, isAdoptable: isAdoptable, size: size)
            
            content(properties)
                .frame(width: size.width, height: size.height)
        }
    }
    
    /**
     Determines if the app is in a split view.
     
     - Returns: A boolean value indicating whether the app is in a split view.
     */
    func isSplit() -> Bool {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }
        return screen.windows.first?.frame.size != screen.screen.bounds.size
    }
}

/**
 A structure holding properties for adaptable UI.
 */
struct Properties {
    var isLandscape: Bool
    var isiPad: Bool
    var isSplit: Bool
    /// If the App size is reduced more than 1/3 in split mode on iPad.
    var isMaxSplit: Bool
    var isAdoptable: Bool
    var size: CGSize
}

