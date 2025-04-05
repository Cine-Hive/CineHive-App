//
//  BoardForRequest.swift
//  CineHive
//
//  Created by 이종민 on 3/26/25.
//

import Foundation

struct BoardForRequest: Codable {
    let email: String
    let title: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case email = "memEmail"
        case title = "brdTitle"
        case content = "brdContent"
    }
}
