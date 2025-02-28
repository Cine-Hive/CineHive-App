//
//  LoginResponse.swift
//  CineHive
//
//  Created by 존진 on 3/1/25.
//

import Foundation

struct LoginResponse: Codable {
    let message: String
    let user: UserData
}

struct UserData: Codable {
    let genres: [String]?
    let name: String?
    let nickname: String
    let email: String
}
