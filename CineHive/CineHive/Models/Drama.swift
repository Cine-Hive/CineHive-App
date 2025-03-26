//
//  Drama.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation

// MARK: - 드라마 모델
struct Drama: Identifiable, Codable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let backDropPath: String?
    let firstAirDate: String
    let voteAverage: Double
    let popularity: Double
    let directors: [Director]?
    let genres: [Genre]
    let actors: [Actor]
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backDropURL: URL? {
        guard let path = backDropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

}

enum DramaListType {
    case drama
    case etc
}

// MARK: - 드라마 상세 검색용 모델
extension Drama {
    static var example: Drama {
        Drama(
            id: 1,
            name: "슬기로운 의사생활",
            overview: "함께 의대를 졸업하고 같은 병원에서 일하게 된 99학번 20년지기 친구들의 우정과 사랑, 그리고 평범한 일상을 그린 의학 드라마",
            posterPath: "/oQHQMRoiY5zQh7JrYqOuNyDdAm4.jpg",
            backDropPath: "/keIxh0wVr56ZmOSAEjU1kYLR0Kg.jpg",
            firstAirDate: "2020-03-12",
            voteAverage: 8.8,
            popularity: 28.5,
            directors: [
                Director(id: 101, name: "신원호")
            ],
            genres: [
                Genre(id: 18, name: "드라마")
            ],
            actors: [
                Actor(id: 201, name: "조정석", posterPath: "/actor1.jpg"),
                Actor(id: 202, name: "유연석", posterPath: "/actor2.jpg"),
                Actor(id: 203, name: "정경호", posterPath: "/actor3.jpg")
            ]
        )
    }
}

// MARK: - 드라마 리스트 응답 모델
typealias DramaListResponse = [Drama]
