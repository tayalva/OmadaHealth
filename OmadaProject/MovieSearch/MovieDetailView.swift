//
//  MovieDetailView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import SwiftUI
import SwiftData

/// A view that displays detailed information about a given movie.
/// It shows the movie's title, release year, poster image, rating, and an overview section.
/// Use this view to present comprehensive details of a selected movie.
struct MovieDetailView: View {
    @Query var favorites: [Movie]
    @Environment(\.modelContext) var modelContext
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        print("Movie: \(movie.id)")
    }
    
    private var isFavorite: Bool {
        favorites.contains { $0.id == movie.id }
    }
    
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
        .overlay(alignment: .topTrailing) {
            Button {
                favoriteTapped()
            } label: {
                if isFavorite {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
            }
            .padding()
        }
    }
    
    private func favoriteTapped() {
        if let managedFavorite = favorites.first(where: { $0.id == movie.id }) {
            modelContext.delete(managedFavorite) // delete the managed instance
        } else {
            modelContext.insert(movie) // or consider inserting a new managed copy
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
