//
//  Review.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import Foundation

struct Review: Identifiable {
    let id = UUID()
    var username: String
    var rating: Double
    var comment: String
    var likes: Int
}
