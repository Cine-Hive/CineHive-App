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
            posterUrl: "/dummyActor1.jpg"
        )
    }
    
    static var dummy2: Actor {
        Actor(
            id: 2,
            name: "김철수",
            posterUrl: "/dummyActor2.jpg"
        )
    }
}

// MARK: - Video 더미 데이터
extension Video {
    static var dummy: Video {
        Video(
            id: 1,
            videoKey: "dummyKey",
            name: "공식 예고편"
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
            overview: "이 영화는 예시로 사용되는 더미 데이터입니다. 영화의 줄거리와 설명이 포함되어 있으며, 실제 서비스에서 사용할 데이터와 유사한 형식으로 작성되었습니다. 이 영화는 예시로 사용되는 더미 데이터입니다. 영화의 줄거리와 설명이 포함되어 있으며, 실제 서비스에서 사용할 데이터와 유사한 형식으로 작성되었습니다. 이 영화는 예시로 사용되는 더미 데이터입니다. 영화의 줄거리와 설명이 포함되어 있으며, 실제 서비스에서 사용할 데이터와 유사한 형식으로 작성되었습니다.",
            posterPath: "/fantasy1.jpg",
            releaseDate: "2025-02-28",
            genreIds: [28, 12, 16],
            voteAverage: 7.8,
            popularity: 1234.5,
            actors: [Actor.dummy, Actor.dummy2],
            videos: [Video.dummy],
            director: Director.dummy
        )
    }
}
