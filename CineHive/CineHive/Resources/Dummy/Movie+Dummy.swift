//
//  Movie+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import Foundation

// MARK: - Movie 더미 데이터
extension Movie {
    static var dummy1: Movie {
        Movie(
            id: 101,
            posterPath: "/q719jXXEzOoYaps6babgKnONONX.jpg",
            backDropPath: "/a3dU5WYYWJNqXusCphwJZkWwTOi.jpg",
            title: "액션 블록버스터",
            releaseDate: "2025-03-15",
            genres: ["액션", "스릴러"]
        )
    }
    
    static var dummy2: Movie {
        Movie(
            id: 102,
            posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
            backDropPath: "/j9GXPw4C2v0b7nJp5OXwKf2pM3C.jpg",
            title: "SF 모험",
            releaseDate: "2025-04-20",
            genres: ["SF", "모험"]
        )
    }
    
    static var dummy3: Movie {
        Movie(
            id: 103,
            posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
            backDropPath: "/vIgyYkXkg6NC2whRbYjBD7eb3Er.jpg",
            title: "로맨틱 코미디",
            releaseDate: "2025-02-14",
            genres: ["로맨스", "코미디"]
        )
    }
    
    static var dummy4: Movie {
        Movie(
            id: 104,
            posterPath: "/xu7JiLVSXW0PSLCJMwqLKAAJGM2.jpg",
            backDropPath: "/dM2w364MScsjFf8pfMbaWUcWrR.jpg",
            title: "드라마 걸작",
            releaseDate: "2025-05-10",
            genres: ["드라마"]
        )
    }
    
    static var dummy5: Movie {
        Movie(
            id: 105,
            posterPath: "/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg",
            backDropPath: "/vnNLcHsXQ5N9dDLsNJW2Bm8UNmG.jpg",
            title: "공포 스릴러",
            releaseDate: "2025-01-30",
            genres: ["공포", "스릴러"]
        )
    }
    
    static var dummy6: Movie {
        Movie(
            id: 106,
            posterPath: "/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
            backDropPath: "/2lBOQK06tltt8SQaswgb8d657Mv.jpg",
            title: "애니메이션 어드벤처",
            releaseDate: "2025-06-05",
            genres: ["애니메이션", "모험"]
        )
    }
    
    static var dummyMovies: [Movie] {
        return [dummy1, dummy2, dummy3, dummy4, dummy5, dummy6]
    }
}
