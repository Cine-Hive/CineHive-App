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
    let createdAt: String
    let likeCount: Int
    let views: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "brdTitle"
        case content = "brdContent"
        case author = "memNickname"
        case createdAt = "brgRegDate"
        case likeCount
        case views
    }
}
