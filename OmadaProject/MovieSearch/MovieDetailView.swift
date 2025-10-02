//
//  MovieDetailView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import SwiftUI

/// A view that displays detailed information about a given movie.
/// It shows the movie's title, release year, poster image, rating, and an overview section.
/// Use this view to present comprehensive details of a selected movie.
struct MovieDetailView: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            MovieCellView(
                title: movie.title,
                year: .full(movie.releaseDate),
                imageURL: movie.posterImageURL,
                rating: movie.voteAverage
            )
            .padding()
            .lineSeparator(positions: [.top])
            
            overViewSection()
            Spacer()
        }
    }
    
    private func overViewSection() -> some View {
        VStack(alignment: .leading) {
            Text("OVERVIEW")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
            
            Text(movie.overview)
                .font(.body)
                .padding(.top, 8)
        }
        .padding()
        .lineSeparator(positions: [.top, .bottom])
    }
}

#Preview {
    MovieDetailView(movie: Movie())
}
