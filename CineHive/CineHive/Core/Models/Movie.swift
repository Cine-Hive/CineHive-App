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
    let title: String
    let releaseDate: String
    let genres: [String]
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backDropURL: URL? {
        guard let path = backDropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w1920\(path)")
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
    let actors: [Actor]?
    let videos: [Video]?
    let director: Director?
    let runtime: Int
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backDropURL: URL? {
        guard let path = backDropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w1280\(path)")
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
}
