//
//  GenreMovies+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/24/25.
//

import Foundation

// MARK: - 장르별 영화 더미 데이터
extension Movie {
    // 전쟁 영화
    static var warMovie1 = Movie(
        id: 975,
        posterPath: "/382xZKXOfuILUQ4HsqCGPLk8fgA.jpg",
        backDropPath: "/nbMY2UcNnaAr3jrrowzN0NaxQyr.jpg",
        title: "영광의 길",
        releaseDate: "1957-10-25",
        genres: ["전쟁", "드라마", "역사"]
    )
    
    static var warMovie2 = Movie(
        id: 25237,
        posterPath: "/baK79h2An0J8mzTue13KThAeYC5.jpg",
        backDropPath: "/oIQMt3Q6Qa37YD0JOdYkrIAPYDk.jpg",
        title: "컴 앤 씨",
        releaseDate: "1985-10-17",
        genres: ["드라마", "전쟁"]
    )
    
    static var warMovie3 = Movie(
        id: 299534,
        posterPath: "/z7ilT5rNN9kDo8JZmgyhM6ej2xv.jpg",
        backDropPath: "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg",
        title: "어벤져스: 엔드게임",
        releaseDate: "2019-04-24",
        genres: ["모험", "SF", "액션"]
    )
    
    static var warMovie4 = Movie(
        id: 299536,
        posterPath: "/kmP6viwzcEkZeoi1LaVcQemcvZh.jpg",
        backDropPath: "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg",
        title: "어벤져스: 인피니티 워",
        releaseDate: "2018-04-25",
        genres: ["모험", "SF", "액션"]
    )
    
    static var warMovies: [Movie] {
        return [warMovie1, warMovie2, warMovie3, warMovie4]
    }
    
    // 드라마 영화
    static var dramaMovie1 = Movie(
        id: 10376,
        posterPath: "/78wbKjbdIG11hVIv55g6rwgLG3l.jpg",
        backDropPath: "/muSeX7fnNw0pv4zHK7RSwZln6Hk.jpg",
        title: "피아니스트의 전설",
        releaseDate: "1998-10-28",
        genres: ["드라마", "음악"]
    )
    
    static var dramaMovie2 = Movie(
        id: 630566,
        posterPath: "/2XyVG0QUnPrukgV5Frpn40kkIky.jpg",
        backDropPath: "/L7DIiAdP8DnNqOh7454ZrTYspR.jpg",
        title: "클라우즈",
        releaseDate: "2020-10-09",
        genres: ["음악", "드라마", "로맨스"]
    )
    
    static var dramaMovie3 = Movie(
        id: 29259,
        posterPath: "/e0jiNoXdEi2ilGRvhqcaoNCSglg.jpg",
        backDropPath: "/f72GEQF2lKsdmEULSI9bWCbQylH.jpg",
        title: "구멍",
        releaseDate: "1960-03-18",
        genres: ["드라마", "스릴러", "범죄"]
    )
    
    static var dramaMovie4 = Movie(
        id: 490132,
        posterPath: "/dyqQ12gZGwl5Y0R9UsLBDkZWOUA.jpg",
        backDropPath: "/5En0fmDagt3Pk8d7P3uTwfeQceg.jpg",
        title: "그린 북",
        releaseDate: "2018-11-16",
        genres: ["드라마", "역사"]
    )
    
    static var dramaMovies: [Movie] {
        return [dramaMovie1, dramaMovie2, dramaMovie3, dramaMovie4]
    }
    
    // 애니메이션 영화
    static var animationMovie1 = Movie(
        id: 8587,
        posterPath: "/9Y048zYw66TWvpUtsiNK0uReiVX.jpg",
        backDropPath: "/wXsQvli6tWqja51pYxXNG1LFIGV.jpg",
        title: "라이온 킹",
        releaseDate: "1994-06-15",
        genres: ["가족", "애니메이션", "드라마"]
    )
    
    static var animationMovie2 = Movie(
        id: 823219,
        posterPath: "/8ntMUYy0b0NIGWSWvMr07ui7CCJ.jpg",
        backDropPath: "/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg",
        title: "플로우",
        releaseDate: "2024-08-29",
        genres: ["애니메이션", "판타지", "모험"]
    )
    
    static var animationMovie3 = Movie(
        id: 995133,
        posterPath: "/rtrXpardqbtPtkWDtCQOX7218LM.jpg",
        backDropPath: "/wO0MIGcA7w7tBI9Ey80Q4Z7qnPm.jpg",
        title: "'소년과 두더지와 여우와 말'",
        releaseDate: "2022-12-25",
        genres: ["애니메이션", "가족", "모험", "판타지"]
    )
    
    static var animationMovie4 = Movie(
        id: 508965,
        posterPath: "/AdcGUXl16jIgq7NZVpfNqhFyaRQ.jpg",
        backDropPath: "/mlxKite1x1PgmIhJgAxNS9eHmH8.jpg",
        title: "클라우스",
        releaseDate: "2019-11-08",
        genres: ["애니메이션", "가족", "모험", "판타지", "코미디"]
    )
    
    static var animationMovies: [Movie] {
        return [
            animationMovie1, animationMovie2, animationMovie3, animationMovie4,
        ]
    }
    
    // SF 영화
    static var sciFiMovie1 = Movie(
        id: 299534,
        posterPath: "/z7ilT5rNN9kDo8JZmgyhM6ej2xv.jpg",
        backDropPath: "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg",
        title: "어벤져스: 엔드게임",
        releaseDate: "2019-04-24",
        genres: ["SF", "액션", "모험"]
    )
    
    static var sciFiMovie2 = Movie(
        id: 299536,
        posterPath: "/kmP6viwzcEkZeoi1LaVcQemcvZh.jpg",
        backDropPath: "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg",
        title: "어벤져스: 인피니티 워",
        releaseDate: "2018-04-25",
        genres: ["SF", "액션", "모험"]
    )
    
    static var sciFiMovie3 = Movie(
        id: 283566,
        posterPath: "/vpfX1mGVobWlrUGqEzbA2RNPdZF.jpg",
        backDropPath: "/1EAxNqdkVnp48a7NUuNBHGflowM.jpg",
        title: "신 에반게리온 극장판 :ll",
        releaseDate: "2021-03-08",
        genres: ["SF", "애니메이션", "액션", "드라마"]
    )
    
    static var sciFiMovie4 = Movie(
        id: 823219,
        posterPath: "/8ntMUYy0b0NIGWSWvMr07ui7CCJ.jpg",
        backDropPath: "/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg",
        title: "플로우",
        releaseDate: "2024-08-29",
        genres: ["애니메이션", "SF", "모험"]
    )
    
    static var sciFiMovies: [Movie] {
        return [sciFiMovie1, sciFiMovie2, sciFiMovie3, sciFiMovie4]
    }
    
    // 액션 영화
    static var actionMovie1 = Movie(
        id: 299534,
        posterPath: "/z7ilT5rNN9kDo8JZmgyhM6ej2xv.jpg",
        backDropPath: "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg",
        title: "어벤져스: 엔드게임",
        releaseDate: "2019-04-24",
        genres: ["액션", "SF", "모험"]
    )
    
    static var actionMovie2 = Movie(
        id: 299536,
        posterPath: "/kmP6viwzcEkZeoi1LaVcQemcvZh.jpg",
        backDropPath: "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg",
        title: "어벤져스: 인피니티 워",
        releaseDate: "2018-04-25",
        genres: ["액션", "SF", "모험"]
    )
    
    static var actionMovie3 = Movie(
        id: 670,
        posterPath: "/xpa9ybm6tYGna5LseqSXvKpSSJn.jpg",
        backDropPath: "/ctfiTiulaR7GWDd1S2Q4xw4pWTw.jpg",
        title: "올드보이",
        releaseDate: "2003-11-21",
        genres: ["액션", "드라마", "스릴러"]
    )
    
    static var actionMovie4 = Movie(
        id: 283566,
        posterPath: "/vpfX1mGVobWlrUGqEzbA2RNPdZF.jpg",
        backDropPath: "/1EAxNqdkVnp48a7NUuNBHGflowM.jpg",
        title: "신 에반게리온 극장판 :ll",
        releaseDate: "2021-03-08",
        genres: ["액션", "SF", "애니메이션", "드라마"]
    )
    
    static var actionMovies: [Movie] {
        return [actionMovie1, actionMovie2, actionMovie3, actionMovie4]
    }
    
    // 로맨스 영화
    static var romanceMovie1 = Movie(
        id: 630566,
        posterPath: "/2XyVG0QUnPrukgV5Frpn40kkIky.jpg",
        backDropPath: "/L7DIiAdP8DnNqOh7454ZrTYspR.jpg",
        title: "클라우즈",
        releaseDate: "2020-10-09",
        genres: ["로맨스", "드라마", "음악"]
    )
    
    static var romanceMovie2 = Movie(
        id: 447362,
        posterPath: "/rJvw9aHDwaYVjnIZkKUbdsNJ7dB.jpg",
        backDropPath: "/27ZkYMWynuK2qiDP6awc3MsCaOs.jpg",
        title: "우리의 마지막 1년",
        releaseDate: "2020-11-27",
        genres: ["로맨스", "드라마"]
    )
    
    static var romanceMovie3 = Movie(
        id: 527641,
        posterPath: "/8bXlrAzTJKwedmUDKBhiaU7OkqW.jpg",
        backDropPath: "/27ZkYMWynuK2qiDP6awc3MsCaOs.jpg",
        title: "파이브 피트",
        releaseDate: "2019-03-14",
        genres: ["로맨스", "드라마"]
    )
    
    static var romanceMovie4 = Movie(
        id: 504253,
        posterPath: "/g1ucSvfDnV3HEVt8x7YeZ0fAIs2.jpg",
        backDropPath: "/YLyORLsYIjC0d1TFBSpJKk7piP.jpg",
        title: "너의 췌장을 먹고 싶어",
        releaseDate: "2018-09-01",
        genres: ["로맨스", "애니메이션", "드라마"]
    )
    
    static var romanceMovies: [Movie] {
        return [romanceMovie1, romanceMovie2, romanceMovie3, romanceMovie4]
    }
    
    // 모든 장르의 영화
    static var genreMovies: [String: [Movie]] {
        return [
            "전쟁": warMovies,
            "드라마": dramaMovies,
            "애니메이션": animationMovies,
            "SF": sciFiMovies,
            "액션": actionMovies,
            "로맨스": romanceMovies
            // 더 많은 장르 추가 필요
        ]
    }
}
