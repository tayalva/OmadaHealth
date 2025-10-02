//
//  LineSeperatorModifier.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import SwiftUI

/// A reusable SwiftUI ViewModifier that adds separator lines to the top and/or bottom of a view.
/// Use this modifier to easily add thin separator lines above and/or below any SwiftUI view.
struct LineSeparator: ViewModifier {
    enum Positions {
        case top
        case bottom
    }
    
    var positions: [Positions] = [.top, .bottom]
    var fullWidth = false
    
    func body(content: Content) -> some View {
        VStack {
            if positions.contains(.top) {
                lineSeparator()
            }
        
            content
            
            if positions.contains(.bottom) {
                lineSeparator()
            }
            
        }
        
    }
    
    /// Creates the separator line view with appropriate styling and padding.
    func lineSeparator() -> some View {
        Rectangle()
            .frame(height: 1)
            .opacity(0.2)
            .padding(.leading, fullWidth ? 0 : 16)
    }
}

extension View {
    /// Adds separator lines to the specified positions (top and/or bottom) of the view.
    /// - Parameters:
    ///   - positions: An array specifying where to place the separators (.top, .bottom).
    ///   - fullWidth: A Boolean value indicating whether the separator should span the full width.
    /// - Returns: A view with the specified separator lines added.
    func lineSeparator(positions: [LineSeparator.Positions], fullWidth: Bool = false) -> some View {
        self.modifier(LineSeparator(positions: positions, fullWidth: fullWidth))
    }
}
