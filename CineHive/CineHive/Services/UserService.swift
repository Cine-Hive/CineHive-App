//
//  UserService.swift
//  CineHive
//
//  Created by 존진 on 2/22/25.
//

import Foundation
import Supabase

final class UserService {
    static let shared = UserService()
    private init() {}
    
    private let auth = SupabaseManager.shared.auth
    
    // MARK: - 인증 없는 요청 (로그인 전)

    /// 회원가입 요청
    func registerUser(user: AuthSignUpRequest) async throws {
        try await auth.signUp(email: user.email, password: user.password)
    }
    
    /// 닉네임 중복 확인
    func fetchUserNickname(nickname: String) async throws -> Bool {
        let params: [String: AnyJSON] = ["p_nickname": .string(nickname)]
        let available = try await SupabaseManager.shared.callRPCBool("check_nickname_available", params: params)
        // true = 사용 가능, false = 중복
        return available
    }
    
    /// 이메일 중복 확인
    func fetchUserEmail(email: String) async throws -> Bool {
        let params: [String: AnyJSON] = ["p_email": .string(email)]
        let available = try await SupabaseManager.shared.callRPCBool("check_email_available", params: params)
        // true = 사용 가능, false = 중복
        return available
    }
    
    /// 로그인 요청
    func loginUser(user: AuthSignUpRequest) async throws {
        try await auth.signIn(email: user.email, password: user.password)
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
