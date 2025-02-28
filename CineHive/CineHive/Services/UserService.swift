//
//  UserService.swift
//  CineHive
//
//  Created by 존진 on 2/22/25.
//

import Foundation

final class UserService {
    static let shared = UserService()
    private init() {}
    
    // 회원가입 요청 (POST)
    func registerUser(user: User) async throws -> SignUpResponse {
        let endpoint = "/register"
        return try await NetworkManager.shared.post(endpoint: endpoint, body: user)
    }
    
    // 닉네임 중복 확인 요청 (GET)
    func fetchUserNickname(nickname: String) async throws -> Bool {
        let endpoint = "/checknickname\(nickname)"
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
    
    // 이메일 중복 확인 요청 (GET)
    func fetchUserEmail(email: String) async throws -> Bool {
        let endpoint = "/checkemail\(email)"
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
}
