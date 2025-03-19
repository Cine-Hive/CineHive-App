//
//  Movie.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let posterPath: String?
    let backDropPath: String?

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backDropURL: URL? {
        guard let path = backDropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}


struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backDropPath: String?
    let releaseDate: String
    let genres: [Genre]
    let voteAverage: Double
    let popularity: Double
    let actors: [Actor] 
    let videos: [Video]?
    let director: Director
    let runtime: Int
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backDropURL: URL? {
        guard let path = backDropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

enum MovieListType {
    case nowPlaying
    case netflixMovies
    case disneyMovies
    case appleTVMovies
    case popular
    case topRated
    case upcoming
    case movies
    case etc
    // 추가 영화 타입이 있을 경우 여기에 작성
}

struct MovieCategory: Identifiable {
    let id = UUID()
    let title: String
    let type: MovieListType
    
    // 영화리스트 카테고리
    static let categories: [MovieCategory] = [
//        MovieCategory(title: "Netflix Top 10 영화", type: .netflixMovies),
//        MovieCategory(title: "Disney+ Top 10 영화", type: .disneyMovies),
//        MovieCategory(title: "Apple TV+ Top 10 영화", type: .appleTVMovies),
        MovieCategory(title: "현재 상영 영화", type: .nowPlaying),
//        MovieCategory(title: "인기 영화", type: .popular),
//        MovieCategory(title: "최고평점 영화", type: .topRated),
//        MovieCategory(title: "개봉예정작", type: .upcoming)
        MovieCategory(title: "영화", type: .movies)
    ]
}

// MARK: - Make MovieCategory Equatable
extension MovieCategory: Equatable {
    static func == (lhs: MovieCategory, rhs: MovieCategory) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.type == rhs.type
    }
}

// MARK: - Make MovieListType Equatable
extension MovieListType: Equatable {
    static func == (lhs: MovieListType, rhs: MovieListType) -> Bool {
        switch (lhs, rhs) {
        case (.nowPlaying, .nowPlaying),
             (.netflixMovies, .netflixMovies),
             (.disneyMovies, .disneyMovies),
             (.appleTVMovies, .appleTVMovies),
             (.popular, .popular),
             (.topRated, .topRated),
             (.upcoming, .upcoming),
             (.movies, .movies),
             (.etc, .etc):
            return true
        default:
            return false
        }
    }
}

// MARK: - Make BannerItem Equatable
extension BannerItem: Equatable {
    static func == (lhs: BannerItem, rhs: BannerItem) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.subtitle == rhs.subtitle &&
               lhs.imageURL == rhs.imageURL
    }
}
