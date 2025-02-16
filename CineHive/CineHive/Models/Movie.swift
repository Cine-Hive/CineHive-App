//
//  Movie.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import Foundation

struct MovieResponse: Codable {
    let dates: DateRange?
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// 날짜 범위 (최신 영화 목록에서 제공)
struct DateRange: Codable {
    let maximum: String
    let minimum: String
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let genreIds: [Int]
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let video: Bool
    let adult: Bool
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(path)")
    }
    
    // API명세서 완료 시, 수정예정
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case video
        case adult
        
    }
}
