//
//  MovieSearchViewModelTests.swift
//  OmadaProjectTests
//
//  Created by Taylor Smith on 10/1/25.
//

import Foundation
import Testing
@testable import OmadaProject

@MainActor
struct MovieSearchViewModelTests {
    
    @Test
    func search() async throws {
        let mockSession = MockURLSession()
        mockSession.setMockResponse(.success)
        mockSession.setMockData(isValid: true)
        let apiManager = APIManager(session: mockSession)
        let viewModel = MovieSearchView.ViewModel(service: apiManager)
        
        await viewModel.search(query: "John Wick")
        
        #expect(viewModel.results.count == 2)
    }
}
