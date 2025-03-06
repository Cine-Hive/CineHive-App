//
//  Actor.swift
//  CineHive
//
//  Created by 이종민 on 2/21/25.
//

import Foundation

struct Actor: Identifiable, Codable {
    let id: Int
    let name: String
    let posterPath: String?
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
