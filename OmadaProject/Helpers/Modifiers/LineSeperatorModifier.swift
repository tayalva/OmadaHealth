//
//  LineSeperatorModifier.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import SwiftUI

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
    
    func lineSeparator() -> some View {
        Rectangle()
            .frame(height: 1)
            .opacity(0.2)
            .padding(.leading, fullWidth ? 0 : 16)
    }
}

extension View {
    func lineSeparator(positions: [LineSeparator.Positions], fullWidth: Bool = false) -> some View {
        self.modifier(LineSeparator(positions: positions, fullWidth: fullWidth))
    }
}
