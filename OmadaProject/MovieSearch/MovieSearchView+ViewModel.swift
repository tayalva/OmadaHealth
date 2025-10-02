//
//  MovieSearchView+ViewModel.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import Foundation
import SwiftUI

extension MovieSearchView {
    @Observable
    class ViewModel {
        var service = APIManager()
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
