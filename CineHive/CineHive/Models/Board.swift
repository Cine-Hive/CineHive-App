//
//  Board.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation

struct Board: Identifiable {
    let id: Int
    var empty: Bool = false
    var title: String = ""
    var content: String = ""
    var author: String = ""
    var category: String = ""
    var createdAt: String = ""
    var viewCount: Int = 0
    var likeCount: Int = 0
    var commentCount: Int = 0
}
