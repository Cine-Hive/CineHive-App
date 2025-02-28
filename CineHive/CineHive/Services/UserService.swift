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
    
    private let userEndpoint = "/checknickname"
    
    // 회원가입 요청 (POST)
    func registerUser(user: User) async throws -> SignUpResponse {
        let endpoint = "/register"
        return try await NetworkManager.shared.post(endpoint: endpoint, body: user)
    }
}
