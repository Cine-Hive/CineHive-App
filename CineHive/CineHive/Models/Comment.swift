//
//  Comment.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation

struct Comment: Identifiable {
    let id: Int
    let content: String
    let author: String
    let email: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case board
        case user
        case createdAt
    }

    enum UserCodingKeys: String, CodingKey {
        case nickname = "memNickname"
        case email = "memEmail"
    }
}
