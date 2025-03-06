//
//  DetailDummy.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import Foundation

// MARK: - Actor 더미 데이터
extension Actor {
    static var dummy: Actor {
        Actor(
            id: 1,
            name: "홍길동",
            posterPath: "/dummyActor1.jpg"
        )
    }
    
    static var dummy2: Actor {
        Actor(
            id: 2,
            name: "김철수",
            posterPath: "/dummyActor2.jpg"
        )
    }
}

// MARK: - Genre 더미 데이터 (추가)
extension Genre {
    static var dummy1: Genre {
        Genre(id: 28, name: "액션")
    }
    
    static var dummy2: Genre {
        Genre(id: 12, name: "모험")
    }
    
    static var dummy3: Genre {
        Genre(id: 16, name: "애니메이션")
    }
}

// MARK: - Video 더미 데이터 (YouTube 예고편 링크 활용)
extension Video {
    static var dummy: Video {
        Video(
            id: 1,
            videoKey: "3x6nwhsEuBo",
            name: "인셉션 - 공식 예고편"
        )
    }
    
    static var dummy2: Video {
        Video(
            id: 2,
            videoKey: "EXeTwQWrcwY",
            name: "다크 나이트 - 공식 예고편"
        )
    }
    
    static var dummy3: Video {
        Video(
            id: 3,
            videoKey: "TcMBFSGVi1c",
            name: "어벤져스: 엔드게임 - 공식 예고편"
        )
    }
    
    static var dummy4: Video {
        Video(
            id: 4,
            videoKey: "5PSNL1qE6VY",
            name: "인터스텔라 - 공식 예고편"
        )
    }
    
    static var dummy5: Video {
        Video(
            id: 5,
            videoKey: "6hB3S9bIaco",
            name: "쇼생크 탈출 - 공식 예고편"
        )
    }
}

// MARK: - Director 더미 데이터
extension Director {
    static var dummy: Director {
        Director(
            id: 1,
            name: "이종민 감독"
        )
    }
}

// MARK: - MovieDetail 더미 데이터
extension MovieDetail {
    static var dummy: MovieDetail {
        MovieDetail(
            id: 1,
            title: "더미 영화 제목",
            overview: """
            이 영화는 예시로 사용되는 더미 데이터입니다. 영화의 줄거리와 설명이 포함되어 있으며, 
            실제 서비스에서 사용할 데이터와 유사한 형식으로 작성되었습니다.
            """,
            posterPath: "/iraQz6gdAe8JL45QcBifM1UhQ38.jpg",
            backDropPath: "/mzfx54nfDPTUXZOG48u4LaEheDy.jpg",
            releaseDate: "2025-02-28",
            genres: [Genre.dummy1, Genre.dummy2, Genre.dummy3],
            voteAverage: 7.8,
            popularity: 1234.5,
            actors: [Actor.dummy, Actor.dummy2],
            videos: [Video.dummy, Video.dummy2, Video.dummy3, Video.dummy4, Video.dummy5],
            director: Director.dummy,
            runtime: 120
        )
    }
}
