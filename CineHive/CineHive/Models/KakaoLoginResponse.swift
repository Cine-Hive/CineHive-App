//
//  KakaoLoginResponse.swift
//  CineHive
//
//  Created by 존진 on 3/6/25.
//

import Foundation

struct KakaoLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let refreshTokenExpiresIn: Int
    let idToken: String?
    let tokenType: String
    let scope: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
        case idToken = "id_token"
        case tokenType = "token_type"
        case scope
    }
}

struct KakaoTokenRequest: Codable {
    let idToken: String
    
    enum CodingKeys: String, CodingKey {
        case idToken = "id_token"
    }
}
