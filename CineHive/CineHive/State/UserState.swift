//
//  UserState.swift
//  CineHive
//
//  Created by 이종민 on 3/31/25.
//

import Foundation
import SwiftUI
import Observation
import OSLog

@Observable
final class UserState {
    static let shared = UserState()
    
    // 현재 로그인된 사용자 정보
    var currentUser: UserData?
    
    // 상태 변수
    var isLoggedIn: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?
    
    private init() {
        // 앱 실행 시 저장된 토큰과 사용자 정보 확인
        self.isLoggedIn = AuthManager.shared.isLoggedIn
        if isLoggedIn {
            self.currentUser = AuthManager.shared.getUser()
            Logger.log(.info, category: Logger.auth, message: "기존 사용자 세션 복원: \(self.currentUser?.nickname ?? "Unknown")")
        }
    }
    
    // MARK: - 로그인 관련 메소드
    
    /// 이메일/비밀번호 로그인 처리
    @MainActor
    func login(email: String, password: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            let loginData = LoginUser(email: email, password: password)
            let response = try await UserService.shared.loginUser(user: loginData)
            
            // JWT 토큰과 사용자 정보 저장
            AuthManager.shared.saveToken(response.token)
            AuthManager.shared.saveUser(response.user)
            
            // 상태 업데이트
            self.currentUser = response.user
            self.isLoggedIn = true
            self.isLoading = false
            
            Logger.log(.info, category: Logger.auth, message: "로그인 성공: \(email)")
            return true
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            Logger.log(.error, category: Logger.auth, message: "로그인 실패: \(error.localizedDescription)")
            return false
        } catch {
            self.errorMessage = "로그인 중 오류가 발생했습니다"
            self.isLoading = false
            Logger.log(.error, category: Logger.auth, message: "로그인 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    /// 소셜 로그인 처리
    @MainActor
    func socialLogin(provider: SocialLoginProvider, token: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        // 실제 소셜 로그인 구현은 백엔드 API에 맞게 조정 필요
        // 아래는 예시 코드
        Logger.log(.info, category: Logger.auth, message: "\(provider.rawValue) 소셜 로그인 시도")
        
        // 소셜 로그인 처리 로직 (향후 구현)
        isLoading = false
        return false
    }
    
    /// 로그아웃 처리
    @MainActor
    func logout() {
        Logger.log(.info, category: Logger.auth, message: "로그아웃 요청: \(currentUser?.email ?? "Unknown")")
        AuthManager.shared.logout()
        self.currentUser = nil
        self.isLoggedIn = false
    }
    
    /// 회원가입 처리
    @MainActor
    func signUp(user: User) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await UserService.shared.registerUser(user: user)
            isLoading = false
            
            if response.status == "success" {
                Logger.log(.info, category: Logger.auth, message: "회원가입 성공: \(user.email)")
                return true
            } else {
                self.errorMessage = response.message
                Logger.log(.error, category: Logger.auth, message: "회원가입 실패: \(response.message)")
                return false
            }
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            Logger.log(.error, category: Logger.auth, message: "회원가입 실패: \(error.localizedDescription)")
            return false
        } catch {
            self.errorMessage = "회원가입 중 오류가 발생했습니다"
            self.isLoading = false
            Logger.log(.error, category: Logger.auth, message: "회원가입 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    /// 닉네임 중복 확인
    @MainActor
    func checkNickname(_ nickname: String) async -> (isAvailable: Bool, errorMessage: String?) {
        do {
            let isAvailable = try await UserService.shared.fetchUserNickname(nickname: nickname)
            return (isAvailable, nil)
        } catch {
            Logger.log(.error, category: Logger.auth, message: "닉네임 중복 검사 실패: \(error.localizedDescription)")
            return (false, "닉네임 중복 검사 실패: \(error.localizedDescription)")
        }
    }
    
    /// 이메일 중복 확인
    @MainActor
    func checkEmail(_ email: String) async -> (isAvailable: Bool, errorMessage: String?) {
        do {
            let isAvailable = try await UserService.shared.fetchUserEmail(email: email)
            return (isAvailable, nil)
        } catch {
            Logger.log(.error, category: Logger.auth, message: "이메일 중복 검사 실패: \(error.localizedDescription)")
            return (false, "이메일 중복 검사 실패: \(error.localizedDescription)")
        }
    }
    
    /// JWT 토큰 유효성 검사
    func isTokenValid() -> Bool {
        guard let token = AuthManager.shared.getToken() else {
            return false
        }
        
        // JWT 토큰은 세 부분으로 구성됨: header.payload.signature
        let segments = token.components(separatedBy: ".")
        guard segments.count == 3,
              let payloadData = decodeBase64URL(segments[1]),
              let payload = try? JSONSerialization.jsonObject(with: payloadData) as? [String: Any],
              let expiration = payload["exp"] as? TimeInterval else {
            return false
        }
        
        // 토큰 만료 시간이 현재보다 미래인지 확인
        return Date(timeIntervalSince1970: expiration) > Date()
    }
    
    /// Base64URL 디코딩
    private func decodeBase64URL(_ base64url: String) -> Data? {
        var base64 = base64url
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // 패딩 추가
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        
        return Data(base64Encoded: base64)
    }
}

//소셜 로그인
enum SocialLoginProvider: String {
    case google = "Google"
    case apple = "Apple"
    case kakao = "Kakao"
    case naver = "Naver"
}
