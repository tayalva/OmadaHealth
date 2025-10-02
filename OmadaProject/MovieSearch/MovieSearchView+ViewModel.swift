//
//  MovieSearchView+ViewModel.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import os
import Foundation
import SwiftUI

/// Extension to `MovieSearchView` that contains the `ViewModel` class.
/// This ViewModel handles the business logic for searching movies and managing navigation state.
extension MovieSearchView {
    /// ViewModel for `MovieSearchView` responsible for managing movie search results,
    /// performing searches via the API service, and handling navigation to detail views.
    @Observable
    class ViewModel {
        var service: ApiClient
        var results: [Movie] = []
        var navPath = NavigationPath()
        
        init(service: APIManager = APIManager()) {
            self.service = service
        }
        
        func search(query: String) async {
            do {
                results = try await service.searchMovies(category: .movie(query: query, page: 1))
            } catch {
                Logger().error("Search failed: \(error)")
            }
        }
        
        func goToDetailView(for movie: Movie) {
            navPath.append(movie)
        }
    }
}
