//
//  MovieCellView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import SwiftUI

struct MovieCellView: View {
    var title: String = "Movie Title"
    var year: DateStyle?
    var imageURL: URL?
    var rating: Double?
    
    var maxHeight: CGFloat = 115
    
    var body: some View {
        HStack(alignment: .top) {
            ImageFetcher(
                url: imageURL
            )
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(year?.formattedString ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let rating {
                    viewerRating(rating)
                        .padding(.top, 8)
                }
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity, maxHeight: maxHeight)
    }
    
    func viewerRating(_ rating: Double) -> some View {
        VStack(alignment: .leading) {
            Text("Viewer Rating")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(String(format: "%.1f/10", rating.rounded(toPlaces: 1)))
                .font(.headline)
            ProgressView(rating: rating)
        }
    }
}

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
    MovieCellView(title: "John Wick", year: .full(.now), imageURL: nil, rating: 8.5)
}
