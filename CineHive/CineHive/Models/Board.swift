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
    let author: String
    let category: String
    let createdAt: String
    let viewCount: Int
    var likeCount: Int  // var로 변경
    let commentCount: Int

    // 좋아요 수 업데이트 메소드
    mutating func updateLikeCount(_ newCount: Int) {
        self.likeCount = newCount
    }
    
    // 좋아요 증가 메소드
    mutating func incrementLike() {
        self.likeCount += 1
    }
    
    // 좋아요 감소 메소드
    mutating func decrementLike() {
        if self.likeCount > 0 {
            self.likeCount -= 1
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title = "brdTitle"
        case content = "brdContent"
        case author = "memNickname"
        case category = "brdCategory"
        case createdAt = "brgRegDate"
        case viewCount = "views"
        case likeCount
        case commentCount
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
