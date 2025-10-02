//
//  MockURLSession.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation

/// A protocol that allows for mocking of URLSession. Any other
/// needed functions from URLSession should be added here.
/// This enables dependency injection for network requests,
/// facilitating easier testing by substituting real network calls with mocks.
protocol NetworkSession {
    func data(from: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}

/// A mock implementation of `NetworkSession` used to simulate network requests for testing purposes.
/// 
/// Properties:
/// - `mockData`: The mock data to be returned when a network request is made.
/// - `mockResponse`: The mock URL response to accompany the mock data.
/// - `mockError`: An optional error to be thrown to simulate network failures.
/// 
/// Methods:
/// - `data(from:)`: Returns the mock data and response, or throws the mock error if set.
/// - `setMockResponse(_:)`: Sets the mock HTTP response to simulate different server status codes.
/// - `setMockData(isValid:)`: Sets mock data to either a valid or invalid JSON payload for testing decoding logic.
class MockURLSession: NetworkSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        guard let data = mockData, let response = mockResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
    
    /// Enum representing common HTTP response status codes for mocking purposes.
    enum HTTPResponse: Int {
        case success = 200
        case notFound = 404
        case serverError = 500
        
        /// Creates an `HTTPURLResponse` with the corresponding status code and a fixed URL.
        var urlResponse: HTTPURLResponse? {
            HTTPURLResponse(
                url: URL(string: "https://google.com")!,
                statusCode: self.rawValue,
                httpVersion: nil,
                headerFields: nil
            )
        }
    }
    
    /// Sets the mock HTTP response to simulate different server response scenarios.
    /// - Parameter response: The `HTTPResponse` enum case representing the desired status code.
    func setMockResponse(_ response: HTTPResponse) {
        mockResponse = response.urlResponse
    }
    
    /// Sets the mock data to either valid or invalid JSON for testing decoding and error handling.
    /// - Parameter isValid: A Boolean indicating whether to use valid JSON (`true`) or invalid JSON (`false`).
    func setMockData(isValid: Bool) {
        let validJson = """
{
  "page": 0,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/7dzngS8pLkGJpyeskCFcjPO9qLF.jpg",
      "genre_ids": [28, 53],
      "id": 245891,
      "original_language": "en",
      "original_title": "John Wick",
      "overview": "Ex-hitman John Wick comes out of retirement to track down the gangsters that took everything from him.",
      "popularity": 11.1107,
      "poster_path": "/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg",
      "release_date": "2014-10-22",
      "title": "John Wick",
      "video": false,
      "vote_average": 7.453,
      "vote_count": 20069
    },
    {
      "adult": false,
      "backdrop_path": "/7I6VUdPj6tQECNHdviJkUHD2u89.jpg",
      "genre_ids": [28, 53, 80],
      "id": 603692,
      "original_language": "en",
      "original_title": "John Wick: Chapter 4",
      "overview": "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
      "popularity": 19.4442,
      "poster_path": "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
      "release_date": "2023-03-22",
      "title": "John Wick: Chapter 4",
      "video": false,
      "vote_average": 7.719,
      "vote_count": 7393
    }
  ],
  "total_pages": 2,
  "total_results": 21
}            
""".data(using: .utf8)
        
        let invalidJson = """
            {
            "" : []
            }
            """.data(using: .utf8)
        
        mockData = isValid ? validJson : invalidJson
    }
}
