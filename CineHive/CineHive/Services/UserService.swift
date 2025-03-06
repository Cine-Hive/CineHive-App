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
        let endpoint = "/checknickname/\(nickname)"
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
    
    // 이메일 중복 확인 요청 (GET)
    func fetchUserEmail(email: String) async throws -> Bool {
        let endpoint = "/checkemail/\(email)"
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
    
    // 로그인 요청 (POST)
    func loginUser(user: LoginUser) async throws -> LoginResponse {
        let endpoint = "/login"
        return try await NetworkManager.shared.post(endpoint: endpoint, body: user)
    }
    
    // 카카오 로그인 인증 (GET)
    func loginKakao() async throws -> URL? {
        let endpoint = "/api/auth/kakao"
        let fullURL = "\(NetworkManager.shared.baseURL)\(endpoint)"
        
        // 서버에 요청 후 응답 출력
        guard let url = URL(string: fullURL) else {
            print("유효하지 않은 URL: \(fullURL)")
            return nil
        }
        
        return url
    }
}
