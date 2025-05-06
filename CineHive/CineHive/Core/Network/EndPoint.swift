//
//  EndPoint.swift
//  CineHive
//
//  Created by 이종민 on 3/29/25.
//

import Foundation

// 서버 환경별 baseURL 설정 구조
enum ServerEnvironment {
    // 개발자
    case development
    // 내부 테스트
    case staging
    // 일반 사용자
    case production

    var baseURL: String {
        switch self {
        case .development:
            return "http://localhost:8081"
        case .staging:
            return "https://staging.api.cinehive.com"
        case .production:
            return "https://api.cinehive.com"
        }
    }
}

enum EndPoint {
    static let baseURL = ServerEnvironment.development.baseURL

    enum NowPlaying {
        static let get = "/now_playing"
        static let update = "/update_now_playing"
    }

    enum ReplyBookMark {
        static let toggle = "/reply/bookmark/toggle"
        static let count = "/reply/bookmark/count"
    }

    enum Animation {
        static let list = "/animations"
        static func detail(_ id: Int) -> String { "/animations/\(id)" }
        static func similar(_ id: Int) -> String { "/animations/\(id)/similar" }
    }

    enum UpComingMovie {
        static let update = "/update_upcoming_movie"
        static let list = "/get_upcoming_movies"
    }

    enum PopularMovie {
        static let update = "/update_popular_movie"
        static let list = "/get_popular_movies"
    }

    enum TopMovie {
        static let update = "/update_top_movie"
        static let list = "/get_topmovies"
    }

    enum Movie {
        static let list = "/movies"
        static func detail(_ id: Int) -> String { "/movies/\(id)" }
        static func similar(_ id: Int) -> String { "/movies/\(id)/similar" }
    }

    enum Drama {
        static let list = "/dramas"
        static func detail(_ id: Int) -> String { "/dramas/\(id)" }
    }

    enum Search {
        static let search = "/search"
    }

    enum Reply {
        static let register = "/reply"
        static func userReplies(_ email: String) -> String { "/reply/user/\(email)" }
        static func movieReplies(_ movieId: Int) -> String { "/reply/movie/\(movieId)" }
        static func delete(movieId: Int, replyId: Int) -> String {
            "/reply/\(movieId)/\(replyId)"
        }
    }

    enum ReplyJudge {
        static let like = "/reply/judge/like"
        static let dislike = "/reply/judge/dislike"
        static let likeCount = "/reply/judge/count/like"
        static let dislikeCount = "/reply/judge/count/dislike"
    }

    enum Board {
        static func detail(_ id: Int) -> String { "/boards/\(id)" }
        static func update(_ id: Int) -> String { "/boards/\(id)" }
        static func delete(_ id: Int) -> String { "/boards/\(id)" }
        static let register = "/boards"
        static let search = "/boards/search"
        static let all = "/boards/all"
    }

    enum Comment {
        static func update(boardId: Int, commentId: Int) -> String {
            "/comment/\(boardId)/board/update/\(commentId)"
        }
        static func register(_ boardId: Int) -> String { "/comment/\(boardId)" }
        static func list(_ boardId: Int) -> String { "/comment/\(boardId)/board/all" }
        static func delete(boardId: Int, commentId: Int) -> String {
            "/comment/\(boardId)/board/delete/\(commentId)"
        }
    }

    enum Like {
        static func like(_ boardId: Int) -> String { "/like/\(boardId)" }
        static func cancel(_ boardId: Int) -> String { "/like/\(boardId)" }
        static func count(_ boardId: Int) -> String { "/like/\(boardId)/count" }
    }

    enum Dislike {
        static func dislike(_ boardId: Int) -> String { "/dislike/\(boardId)" }
        static func cancel(_ boardId: Int) -> String { "/dislike/\(boardId)" }
        static func count(_ boardId: Int) -> String { "/dislike/\(boardId)/count" }
    }

    enum Bookmark {
        static func add(_ boardId: Int) -> String { "/bookmark/\(boardId)" }
        static func cancel(_ boardId: Int) -> String { "/bookmark/\(boardId)" }
        static func count(_ boardId: Int) -> String { "/bookmark/\(boardId)/count" }
    }

    enum Report {
        static func submit(_ boardId: Int) -> String { "/report/\(boardId)" }
    }

    enum PreferredGenre {
        static let select = "/preferredGenres"
    }

    enum Auth {
        static let register = "/register"
        static let login = "/login"
        static func checkNickname(_ nickname: String) -> String { "/checknickname/\(nickname)" }
        static func checkEmail(_ email: String) -> String { "/checkemail/\(email)" }
    }

    enum GoogleAuth {
        static let redirect = "/api/auth/google"
        static let success = "/api/auth/google/success"
        static let loginSuccess = "/api/auth/google/login/success"
        static let callback = "/api/auth/google/callback"
        static let register = "/api/auth/google/register"
        static let appLogin = "/api/auth/google/app-login"
    }

    enum NaverAuth {
        static let redirect = "/api/auth/naver"
        static let success = "/api/auth/naver/success"
        static let loginSuccess = "/api/auth/naver/login/success"
        static let callback = "/api/auth/naver/callback"
        static let register = "/api/auth/naver/register"
        static let appLogin = "/api/auth/naver/app-login"
    }

    enum KakaoAuth {
        static let redirect = "/api/auth/kakao"
        static let success = "/api/auth/kakao/success"
        static let loginSuccess = "/api/auth/kakao/login/success"
        static let callback = "/api/auth/kakao/callback"
        static let register = "/api/auth/kakao/register"
        static let appLogin = "/api/auth/kakao/app-login"
    }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

