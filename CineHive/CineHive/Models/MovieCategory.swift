//
//  MovieCategory.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import Foundation

enum MovieListType {
    case nowPlaying
    case netflixMovies
    case disneyMovies
    case appleTVMovies
    case isLoading
    case popular
    case topRated
    case upcoming
    case etc
    // 추가 영화 타입이 있을 경우 여기에 작성
}

struct MovieCategory: Identifiable {
    let id = UUID()
    let title: String
    let type: MovieListType
    
    // 영화리스트 카테고리
    static let categories: [MovieCategory] = [
        MovieCategory(title: "Netflix Top 10 영화", type: .netflixMovies),
        MovieCategory(title: "Disney+ Top 10 영화", type: .disneyMovies),
        MovieCategory(title: "Apple TV+ Top 10 영화", type: .appleTVMovies),
        MovieCategory(title: "현재 상영 영화", type: .nowPlaying),
        MovieCategory(title: "인기 영화", type: .popular),
        MovieCategory(title: "최고평점 영화", type: .topRated),
        MovieCategory(title: "개봉예정작", type: .upcoming)
    ]
}
