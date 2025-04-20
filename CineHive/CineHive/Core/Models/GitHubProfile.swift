//
//  GitHubProfile.swift
//  CineHive
//
//  Created by 이종민 on 4/16/25.
//

import SwiftUI

struct GitHubProfile: Codable, Equatable {
    let login: String
    let avatarUrl: String
    let name: String?
    let bio: String?
    let publicRepos: Int
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case name
        case bio
        case publicRepos = "public_repos"
        case followers
        case following
    }
}

enum ProfileLoadState {
    case loading
    case loaded(GitHubProfile)
    case error(String)
    case idle
}
