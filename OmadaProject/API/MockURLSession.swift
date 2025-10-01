//
//  MockURLSession.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation

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
}

// A protocol that allows for mocking of URLSession. Any other
// needed functions from URLSession should be added here.
protocol NetworkSession {
    func data(from: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}

