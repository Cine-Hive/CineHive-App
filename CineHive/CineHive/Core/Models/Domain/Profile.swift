//
//  User.swift
//  CineHive
//
//  Created by 존진 on 2/22/25.
//

import Foundation
import Supabase

// MARK: - 도메인 모델: 앱 내부 표준
struct Profile: Codable {
    let id: UUID
    let email: String
    let name: String?
    let nickname: String
    let gender: Gender?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case nickname
        case gender
        case genres
    }
    
    enum Gender: String, Codable {
        case male = "MALE"
        case female = "FEMALE"
        case other = "OTHER"
    }
    
    // 기본 생성자
    init(id:UUID, email: String, name: String?, nickname: String, gender: Gender?, genres: [String]?) {
        self.id = id
        self.email = email
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
