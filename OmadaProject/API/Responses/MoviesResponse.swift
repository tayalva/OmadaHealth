//
//  MoviesResponse.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let results: [ServerMovie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ServerMovie: Codable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let backdropPath: String?
    let posterPath: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let video: Bool
    let adult: Bool

    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity, video, adult
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
