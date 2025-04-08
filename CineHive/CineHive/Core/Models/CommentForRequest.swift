//
//  CommentForRequest.swift
//  CineHive
//
//  Created by 이종민 on 3/27/25.
//

import Foundation

struct CommentForRequest: Codable {
    let id: Int?
    let content: String
    let nickname: String
    let email: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case nickname = "memNickname"
        case email = "memEmail"
        case createdAt = "brgRedDate"
    }
    
    init(id: Int? = nil, content: String, nickname: String, email: String, createdAt: String = "") {
        self.id = id
        self.content = content
        self.nickname = nickname
        self.email = email
        self.createdAt = createdAt
    }
}
