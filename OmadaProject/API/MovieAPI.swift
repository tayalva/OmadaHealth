//
//  MovieAPI.swift
//  OmadaProject
//
//  Created by Taylor Smith on 9/30/25.
//

import Foundation

/// Handles API endpoints for movies, search, and related resources in The Movie Database (TMDb) API.
/// Provides cases and functionality to construct URLs for various endpoints such as searching movies, collections, companies, keywords, multi, people, and TV shows.
enum MovieAPI {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/original"
    static let apiKey: String = "b11fc621b3f7f739cb79b50319915f1d"
    
    case search(SearchCategory)
}

/// Represents different search categories for TMDb API.
/// Each case includes the search query and supports pagination through the `page` parameter.
enum SearchCategory {
    case movie(query: String, page: Int = 1)
    case collection(String, page: Int = 1)
    case company(String, page: Int = 1)
    case keyword(String, page: Int = 1)
    case multi(String, page: Int = 1)
    case person(String, page: Int = 1)
    case tv(String, page: Int = 1)

    /// Returns the endpoint string for the search category (e.g., "movie", "collection").
    var endpoint: String {
        switch self {
        case .movie: return "movie"
        case .collection: return "collection"
        case .company: return "company"
        case .keyword: return "keyword"
        case .multi: return "multi"
        case .person: return "person"
        case .tv: return "tv"
        }
    }

    /// Returns the search query string associated with the category.
    var query: String {
        switch self {
        case let .movie(query, _),
             let .collection(query, _),
             let .company(query, _),
             let .keyword(query, _),
             let .multi(query, _),
             let .person(query, _),
             let .tv(query, _):
            return query
        }
    }

    /// Returns the page number for paginated search results.
    var page: Int {
        switch self {
        case let .movie(_, page),
             let .collection(_, page),
             let .company(_, page),
             let .keyword(_, page),
             let .multi(_, page),
             let .person(_, page),
             let .tv(_, page):
            return page
        }
    }
}

extension MovieAPI {
    /// Returns the relative path string for the API request, including query parameters such as API key, language, and pagination.
    /// Returns `nil` if the path cannot be constructed (e.g., due to encoding issues or unsupported cases).
    var path: String? {
        let apiKeyParam = "?api_key=\(MovieAPI.apiKey)"
        let languageParam = "&language=en-US"
        let adultParam = "&include_adult=false"
        
        switch self {
        case .search(let category):
            guard let encodedQuery = category.query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                return nil
            }
            
            switch category {
            case .movie:
                return "/search/\(category.endpoint)"
                + apiKeyParam
                + languageParam
                + "&query=\(encodedQuery)"
                + "&page=\(category.page)"
                + adultParam
                
            default:
                return nil
            }
        }
    }
    
    /// Returns the complete URL for the API request by combining the base URL with the constructed path.
    /// Returns `nil` if the path is invalid or cannot be constructed.
    var url: URL? {
        guard let path else { return nil }
        return URL(string: MovieAPI.baseURL + path)
    }
}
