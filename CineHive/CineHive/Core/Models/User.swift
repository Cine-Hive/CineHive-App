//
//  User.swift
//  CineHive
//
//  Created by 존진 on 2/22/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int?
    let email: String
    let password: String
    let nickname: String
    let name: String?
    let gender: String?
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "mem_id"
        case email = "memEmail"
        case password = "memPassword"
        case nickname = "memNickname"
        case name = "memName"
        case gender = "memSex"
        case type = "memType"
    }
    
    // 기본 생성자
    init(id: Int? = nil, email: String, password: String, nickname: String, name: String?, gender: String?, type: String) {
        self.id = id
        self.email = email
        self.password = password
        self.nickname = nickname
        self.name = name
        self.gender = gender
        self.type = type
    }
}

struct LoginUser: Codable {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    enum CodingKeys: String, CodingKey {
        case email = "memEmail"
        case password = "memPassword"
    }
}

struct LoginResponse: Codable {
    let message: String?
    let user: UserData
    let token: String
}

struct SocialLoginResponse: Codable, ResponseWithStatusCode {
    var statusCode: Int?
    let user: UserData
    let token: String?

    enum CodingKeys: String, CodingKey {
        case statusCode
        case user
        case token
    }

    mutating func injectStatusCode(_ code: Int) {
        self.statusCode = code
    }
}

struct UserData: Codable {
    let genres: [String]?
    let name: String?
    let nickname: String
    let email: String
    let gender: String?
    
    enum CodingKeys: String, CodingKey {
        case genres
        case name
        case nickname
        case email
        case gender
    }
}

struct SignUpResponse: Codable {
    let message: String
    let status: String
}
