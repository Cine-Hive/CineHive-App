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
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    // 수정예정
    //    var backdropURL: URL? {
    //        guard let path = backdropPath else { return nil }
    //        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    //    }
}

struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let genreIds: [Int]
    let voteAverage: Double
    let popularity: Double
    let actors: [Actor]
    let videos: [Video]?
    let director: Director
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
