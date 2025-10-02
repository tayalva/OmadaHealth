//
//  MovieCellView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import SwiftUI

/// A view that displays a movie's basic information including its title, release year, image, and viewer rating.
/// This view is designed to be used within lists or collections to present a summary of a movie.
/// It supports displaying an optional image from a URL, formatted release year, and a rating with a progress view.
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

#Preview {
    MovieCellView(title: "John Wick", year: .full(.now), imageURL: nil, rating: 8.5)
}
