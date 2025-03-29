//
//  Comment.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation

struct Comment: Identifiable, Codable {
    let id: Int
    let content: String
    let user: User
    let createdAt: String
    var author: String { user.nickname }
    var email: String { user.email }

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case user
        case createdAt = "brgRedDate"
    }
}
