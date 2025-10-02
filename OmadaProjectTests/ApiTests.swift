//
//  OmadaProjectTests.swift
//  OmadaProjectTests
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation
import Testing
@testable import OmadaProject

@MainActor
struct ApiTests {
    let mockSession = MockURLSession()
    
    @Test
    func performRequestValid() async throws {
        mockSession.setMockResponse(.success)
        mockSession.setMockData(isValid: true)
        
        let apiManager = APIManager(session: mockSession)
        let response: MoviesResponse = try await apiManager.performRequest(
            url: URL(string: "https:/b/test.com")!
        )
        
        #expect(response.results.count == 2)
        #expect(response.results.first?.title == "John Wick")
    }
    
    @Test
    func searchMoviesSuccess() async throws {
        mockSession.setMockResponse(.success)
        mockSession.setMockData(isValid: true)
        
        let apiManager = APIManager(session: mockSession)
        let movies = try await apiManager.searchMovies(category: .movie(query: "John Wick"))
        
        #expect(movies.count == 2)
        #expect(movies.first?.title == "John Wick")
    }
}
