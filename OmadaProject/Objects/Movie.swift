//
//  Movie.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import Foundation

/// The main app movie object representing a movie in the OmadaProject.
///
/// This struct encapsulates all relevant movie data used throughout the app, such as title, language, overview, release date, genre IDs, image URLs, popularity, voting statistics, and flags for video and adult content.
///
/// Movies received from the server as `ServerMovie` are converted into this type for use in the app.
///
/// - Properties:
///   - `id`: Unique identifier for the movie.
///   - `title`: The movie's title.
///   - `originalTitle`: The original title in the original language.
///   - `originalLanguage`: The language code of the original movie.
///   - `overview`: A summary of the movie.
///   - `releaseDate`: The date the movie was released.
///   - `genreIds`: List of genre IDs associated with the movie.
///   - `backdropImageURL`/`posterImageURL`: URLs for movie images.
///   - `popularity`, `voteAverage`, `voteCount`: Popularity and voting data.
///   - `video`: Indicates if the movie has a video.
///   - `adult`: Indicates if the movie is for adults.
struct Movie: Identifiable, Hashable {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let releaseDate: Date?
    let genreIds: [Int]
    var backdropImageURL: URL?
    var posterImageURL: URL?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let video: Bool
    let adult: Bool
    
    init(
        id: Int = 0,
        title: String = "John Wick",
        originalTitle: String = "John Wick",
        originalLanguage: String = "English",
        overview: String = "Man destroys world because of a puppy and a car.",
        releaseDate: Date? = .now,
        genreIds: [Int] = [],
        backdropImageURL: URL? = nil,
        posterImageURL: URL? = nil,
        popularity: Double = 10.0,
        voteAverage: Double = 10.0,
        voteCount: Int = 100,
        video: Bool = false,
        adult: Bool = false
    ) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.backdropImageURL = backdropImageURL
        self.posterImageURL = posterImageURL
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.video = video
        self.adult = adult
    }
    
    init(serverMovie: ServerMovie) {
        self.id = serverMovie.id
        self.title = serverMovie.title
        self.originalTitle = serverMovie.originalTitle
        self.originalLanguage = serverMovie.originalLanguage
        self.overview = serverMovie.overview
        
        self.releaseDate = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: serverMovie.releaseDate)
        }()
        
        self.genreIds = serverMovie.genreIds
        
        if let backdropPath = serverMovie.backdropPath {
            self.backdropImageURL = URL(string: MovieAPI.imageBaseURL + backdropPath)
        }
        
        if let posterPath = serverMovie.posterPath {
            self.posterImageURL = URL(string: MovieAPI.imageBaseURL + posterPath)
        }
        
        self.popularity = serverMovie.popularity
        self.voteAverage = serverMovie.voteAverage
        self.voteCount = serverMovie.voteCount
        self.video = serverMovie.video
        self.adult = serverMovie.adult
    }
}
