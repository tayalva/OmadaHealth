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

struct CustomSearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $text)
                    .padding(8)
                    .padding(.horizontal, 30)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)

                            if !text.isEmpty {
                                Button(action: {
                                    text = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .onTapGesture {
                        isEditing = true
                    }
            }
            .padding(.horizontal)
        }
        .contentShape(Rectangle())
    }
}
