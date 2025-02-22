//
//  MovieDummy.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import Foundation

extension Movie {
    static var dummyMovie: Movie {
        return Movie(
            id: 1,
            title: "인셉션",
            overview: "꿈속의 꿈을 탐험하는 한 남자의 이야기.꿈속의 꿈을 탐험하는 한 남자의 이야기.꿈속의 꿈을 탐험하는 한 남자의 이야기.꿈속의 꿈을 탐험하는 한 남자의 이야기.꿈속의 꿈을 탐험하는 한 남자의 이야기.",
            posterPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            backdropPath: "/s3TBrRGB1iav7gFOCNx3H31MoES.jpg",
            releaseDate: "2010-07-16",
            genreIds: [28, 878, 12],
            popularity: 90.5,
            voteAverage: 8.8,
            voteCount: 24000,
            adult: false,
            actors: [
                Actor(id: 1, name: "레오나르도 디카프리오", originalName: "Leonardo DiCaprio", role: "Dom Cobb", gender: 2),
                Actor(id: 2, name: "조셉 고든 레빗", originalName: "Joseph Gordon-Levitt", role: "Arthur", gender: 2)
            ],
            videos: [
                Video(id: 1, videoKey: "YoHD9XEInc0", name: "Inception Official Trailer", site: "YouTube", type: "Trailer")
            ],
            director: Director(id: 1, name: "크리스토퍼 놀란", gender: 2, job: "Director")
        )
    }
}
