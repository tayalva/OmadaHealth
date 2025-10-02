//
//  ProgressView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import SwiftUI

/// A visual progress bar representing a rating value out of 10.
///
/// The `ProgressView` displays a horizontal bar that fills proportionally
/// to the provided `rating`. Useful for visually indicating a score or rating
/// in a compact, animated style.
struct ProgressView: View {
    var rating: Double
    @State private var fillWidth: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 6)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .cornerRadius(3)
                
                Rectangle()
                    .frame(width: fillWidth, height: 6)
                    .foregroundColor(.blue)
                    .cornerRadius(3)
                    .animation(.easeOut(duration: 1.0), value: fillWidth)
            }
            .onAppear {
                fillWidth = geometry.size.width * CGFloat(rating / 10)
            }
        }
        .frame(height: 6)
    }
}

#Preview {
    ProgressView(rating: 7.4)
        .padding()
}
