//
//  Board.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation

struct Board: Identifiable, Codable {
    let id: Int
    let title: String
    let content: String
    let user: User?
    let createdAt: String
    let viewCount: Int
    var likeCount: Int
    let commentCount: Int

    // UI에서 사용하기 위한 유저 정보
    var author: String { user?.nickname ?? "알 수 없음" }
    var email: String { user?.email ?? "unknown@email.com" }

    // 로컬에서 사용하는 더미 카테고리
    var localCategory: String = "자유"

    // 서버에서 내려오는 키 정의
    enum CodingKeys: String, CodingKey {
        case id
        case title = "brdTitle"
        case content = "brdContent"
        case user
        case createdAt = "brgRegDate"
        case viewCount = "views"
        case likeCount
        case commentCount
        case nickname = "memNickname"
    }

    // MARK: - 커스텀 디코더
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.viewCount = try container.decode(Int.self, forKey: .viewCount)
        self.likeCount = try container.decodeIfPresent(Int.self, forKey: .likeCount) ?? 0
        self.commentCount = try container.decodeIfPresent(Int.self, forKey: .commentCount) ?? 0

        // user가 있는 경우와 없는 경우 모두 대응
        if let user = try? container.decode(User.self, forKey: .user) {
            self.user = user
        } else {
            let nickname = try container.decodeIfPresent(String.self, forKey: .nickname) ?? "알 수 없음"
            self.user = User(
                id: nil,
                email: "unknown@email.com",
                password: "",
                nickname: nickname,
                name: nil,
                gender: nil,
                type: "일반"
            )
        }
    }

    // MARK: - 커스텀 인코더
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(viewCount, forKey: .viewCount)
        try container.encode(likeCount, forKey: .likeCount)
        try container.encode(commentCount, forKey: .commentCount)
        try container.encodeIfPresent(user, forKey: .user)
    }

    // 좋아요 수 업데이트 메소드
    mutating func updateLikeCount(_ newCount: Int) {
        self.likeCount = newCount
    }

    mutating func incrementLike() {
        self.likeCount += 1
    }

    mutating func decrementLike() {
        if self.likeCount > 0 {
            self.likeCount -= 1
        }
    }
}

// 게시판 카테고리
enum BoardCategory: String, CaseIterable {
    case all = "전체"
    case free = "자유"
    case review = "리뷰"
    case question = "질문"
    case info = "정보"
    
    // 서버 카테고리 문자열 변환 함수
    func toServerCategory() -> String? {
        switch self {
        case .all: return nil  // 전체는 서버에 카테고리 파라미터 없음
        case .free: return "자유"
        case .review: return "리뷰"
        case .question: return "질문"
        case .info: return "정보"
        }
    }
}

