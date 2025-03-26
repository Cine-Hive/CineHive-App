//
//  Comment.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation

struct Comment: Identifiable {
    let id: Int
    let author: String
    let content: String
    let createdAt: String
    var likeCount: Int
}
