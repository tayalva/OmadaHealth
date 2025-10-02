//
//  MovieSearchView+ViewModel.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import os
import Foundation
import SwiftUI

extension MovieSearchView {
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
