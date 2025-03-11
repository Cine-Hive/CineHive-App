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
        Movie(id: 101, posterPath: "/q719jXXEzOoYaps6babgKnONONX.jpg", backDropPath: "/a3dU5WYYWJNqXusCphwJZkWwTOi.jpg")
    }
    
    static var dummy2: Movie {
        Movie(id: 102, posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", backDropPath: "/j9GXPw4C2v0b7nJp5OXwKf2pM3C.jpg")
    }
    
    static var dummy3: Movie {
        Movie(id: 103, posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", backDropPath: "/vIgyYkXkg6NC2whRbYjBD7eb3Er.jpg")
    }
    
    static var dummy4: Movie {
        Movie(id: 104, posterPath: "/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg", backDropPath: "/dM2w364MScsjFf8pfMbaWUcWrR.jpg")
    }
    
    static var dummy5: Movie {
        Movie(id: 105, posterPath: "/t/t/p/w500/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg", backDropPath: "/w2PMyoyLU22YvrGK3smVM9fW1jj.jpg")
    }
    
    static var dummy6: Movie {
        Movie(id: 106, posterPath: "/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg", backDropPath: "/2lBOQK06tltt8SQaswgb8d657Mv.jpg")
    }
    
    static var dummyMovies: [Movie] {
        return [dummy1, dummy2, dummy3, dummy4, dummy5, dummy6]
    }
}
