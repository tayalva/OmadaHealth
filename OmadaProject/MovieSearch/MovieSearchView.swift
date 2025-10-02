//
//  MovieSearchView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import SwiftUI

/// A view that provides a search interface for movies.
/// Users can enter a search query to find movies, view the results in a scrollable list,
/// and navigate to detailed views of selected movies.
struct MovieSearchView: View {
    @State var viewModel: ViewModel = ViewModel()
    @State var searchText: String = ""
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            
            CustomSearchBar(text: $searchText)
                .lineSeparator(positions: [.top, .bottom], fullWidth: true)
                .focused($isSearchFocused)
            
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(Array(viewModel.results).enumerated(), id: \.offset) { index, movie in
                            MovieCellView(
                                title: movie.title,
                                year: .year(movie.releaseDate),
                                imageURL: movie.posterImageURL
                            )
                            .padding(8)
                            .lineSeparator(positions: index != viewModel.results.count - 1 ? [.bottom] : [])
                            .onTapGesture {
                                isSearchFocused = false
                                viewModel.goToDetailView(for: movie)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Movie Search")
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailView(movie: movie)
                }
                .onTapGesture {
                    isSearchFocused = false
                }
            }
        .onChange(of: searchText) {
            Task {
                await viewModel.search(query: searchText)
            }
        }
        .overlay {
            if searchText.isEmpty {
                Text("No results")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    MovieSearchView()
}
