//
//  MoviesResponse.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation

/// Represents the server response for a movie search, including pagination information
/// and a list of `ServerMovie` objects.
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

/// Represents the raw movie object returned from the server.
///
/// This struct is used to decode the movie data as received from the API before converting
/// it into the app's `Movie` model. It contains properties such as IDs, titles, language,
/// overview, release date, genres, image paths, popularity, and rating details.
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
