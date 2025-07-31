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

struct SocialLoginResponse: Codable {
    let success: Bool
    let data: SocialLoginData

    enum CodingKeys: String, CodingKey {
        case success
        case data
    }
}

struct SocialLoginData: Codable {
    let token: String?
    let isNewMember: Bool
    let memberInfo: UserData
}

struct UserData: Codable {
    let id: Int
    let email: String
    let name: String?
    let nickname: String
    let gender: String?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case nickname
        case gender
        case genres
    }
}

struct SignUpRequest: Codable {
    let email: String
    let password: String
    let name: String?
    let nickname: String
    let gender: String?
    let genres: [String]
}

struct SignUpResponse: Codable {
    let success: Bool
    let data: SignUpResponseData
    let error: ErrorResponse?
}

struct SignUpResponseData: Codable {
    let message: String
}

struct ErrorResponse: Codable {
    let timestamp: String
    let status: Int
    let code: String
    let error: String
    let message: String
    let path: String
    let details: [ErrorDetail]?
}

struct ErrorDetail: Codable {
    let field: String
    let rejectedValue: String
    let reason: String
}

struct AvailabilityResponse: Decodable {
    let success: Bool
    let data: AvailabilityData
}

struct AvailabilityData: Decodable {
    let isAvailable: Bool
}
