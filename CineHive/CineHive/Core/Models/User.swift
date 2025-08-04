//
//  User.swift
//  CineHive
//
//  Created by 존진 on 2/22/25.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String
    let name: String?
    let nickname: String
    let gender: String?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case name
        case nickname
        case gender
        case genres
    }
    
    // 기본 생성자
    init(email: String, password: String, name: String?, nickname: String, gender: String?, genres: [String]?) {
        self.email = email
        self.password = password
        self.name = name
        self.nickname = nickname
        self.gender = gender
        self.genres = genres
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
        case email
        case password
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
