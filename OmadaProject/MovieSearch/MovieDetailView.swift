//
//  MovieDetailView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import SwiftUI

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
