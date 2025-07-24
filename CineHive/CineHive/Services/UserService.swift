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
    
    // MARK: - 인증 없는 요청 (로그인 전)

    /// 회원가입 요청
    func registerUser(user: User) async throws -> SignUpResponse {
        let endpoint = EndPoint.Auth.register
        return try await NetworkManager.shared.post(endpoint: endpoint, body: user)
    }
    
    /// 닉네임 중복 확인
    func fetchUserNickname(nickname: String) async throws -> Bool {
        let endpoint = EndPoint.Auth.checkNickname(nickname)
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
    
    /// 이메일 중복 확인
    func fetchUserEmail(email: String) async throws -> Bool {
        let endpoint = EndPoint.Auth.checkEmail(email)
        return try await NetworkManager.shared.fetch(endpoint: endpoint)
    }
    
    /// 로그인 요청
    func loginUser(user: LoginUser) async throws -> LoginResponse {
        let endpoint = EndPoint.Auth.login
        return try await NetworkManager.shared.post(endpoint: endpoint, body: user)
    }
    
    // MARK: - 인증이 필요한 요청 (로그인 후)
    
    /// 선호 장르 선택
    func selectPreferredGenres(genres: [String]) async throws -> UserData {
        let endpoint = EndPoint.PreferredGenre.select
        
        struct GenresRequest: Codable {
            let genres: [String]
        }
        
        let request = GenresRequest(genres: genres)
        return try await NetworkManager.shared.authenticatedPost(endpoint: endpoint, body: request)
    }
    
    // MARK: - 소셜 로그인 관련
    
    /// 구글 로그인
    func googleLogin(token: String) async throws -> SocialLoginResponse {
        let endpoint = EndPoint.GoogleAuth.appLogin
        
        struct SocialLoginRequest: Codable {
            let accessToken: String
        }
        
        let request = SocialLoginRequest(accessToken: token)
        return try await NetworkManager.shared.post(endpoint: endpoint, body: request)
    }
    
    /// 네이버 로그인
    func naverLogin(token: String) async throws -> SocialLoginResponse {
        let endpoint = EndPoint.NaverAuth.appLogin
        
        struct SocialLoginRequest: Codable {
            let accessToken: String
        }
        
        let request = SocialLoginRequest(accessToken: token)
        return try await NetworkManager.shared.post(endpoint: endpoint, body: request)
    }
    
    /// 카카오 로그인
    func kakaoLogin(token: String) async throws -> SocialLoginResponse {
        let endpoint = EndPoint.KakaoAuth.appLogin
        
        struct SocialLoginRequest: Codable {
            let accessToken: String
        }
        
        let request = SocialLoginRequest(accessToken: token)
        return try await NetworkManager.shared.post(endpoint: endpoint, body: request)
    }
}
