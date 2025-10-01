//
//  MovieSearchView.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import SwiftUI

struct MovieSearchView: View {
    @State var viewModel: ViewModel = ViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(Array(viewModel.results).enumerated(), id: \.offset) { index, movie in
                            MovieCellView(
                                title: movie.title,
                                year: .year(movie.releaseDate),
                                imageURL: movie.posterImageURL
                            )
                            .padding(8)
                            .onTapGesture {
                                viewModel.goToDetailView(for: movie)
                            }
                            
                            if index != viewModel.results.count - 1 {
                                Rectangle()
                                    .frame(height: 1)
                                    .opacity(0.2)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Movie Search")
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailView(movie: movie)
                }
            }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
          
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

extension MovieSearchView {
    @Observable
    class ViewModel {
        var service = APIManager()
        
        var searchText: String = ""
        var results: [Movie] = []
        var navPath = NavigationPath()
        
        func search(query: String) async {
            do {
                results = try await service.searchMovies(category: .movie(query: query, page: 1))
            } catch {
                print(error)
            }
        }
        
        func goToDetailView(for movie: Movie) {
            navPath.append(movie)
        }
    }
}
