//
//  MockURLSession.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation

// A protocol that allows for mocking of URLSession. Any other
// needed functions from URLSession should be added here.
protocol NetworkSession {
    func data(from: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}

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
    
    enum HTTPResponse: Int {
        case success = 200
        case notFound = 404
        case serverError = 500
        
        var urlResponse: HTTPURLResponse? {
            HTTPURLResponse(
                url: URL(string: "https://google.com")!,
                statusCode: self.rawValue,
                httpVersion: nil,
                headerFields: nil
            )
        }
    }
    
    func setMockResponse(_ response: HTTPResponse) {
        mockResponse = response.urlResponse
    }
    
    // Mock data that is valid or invalid for testing.
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
