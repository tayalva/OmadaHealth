//
//  APIManager.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation


protocol APIManagerProtocol {
    
}

class APIManager: APIManagerProtocol {
    var session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func performRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}

extension APIManager {
    func search<T: Decodable>(category: SearchCategory) async throws -> T {
        guard let url = MovieAPI.search(category).url else {
            throw ServiceError.invalidURL
        }
        
        do {
            let response: T = try await performRequest(url: url)
            return response
        } catch {
            throw ServiceError.noData
        }
    }
}

extension APIManager {
    
    // MARK: - Convenience Wrappers
    func searchMovies(category: SearchCategory) async throws -> [Movie] {
        let response: MoviesResponse = try await search(category: category)
        return response.results.map { Movie(serverMovie: $0) }
    }

    // Add wrappers for TV shows, collections, etc.
}

enum ServiceError: LocalizedError {
     case invalidURL
     case noData
    
    var title: String {
        "Uh Oh!"
    }
    
    var failureReason: String? {
        switch self {
        case .invalidURL:
            "We can't read that!"
        case .noData:
            "There was a problem. Please try again later."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .invalidURL:
            "Please check the url."
        case .noData:
            "There's no data!"
        }
    }
 }
