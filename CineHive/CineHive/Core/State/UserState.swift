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
    
    // 게스트 모드 상태
    var isGuestMode: Bool = false
    
    // 네비게이션 상태
    var shouldNavigateToMain: Bool = false
    var shouldNavigateToSignUp: Bool = false
    
    private init() {
        // 앱 실행 시 저장된 토큰과 사용자 정보 확인
        self.isLoggedIn = AuthManager.shared.isLoggedIn
        if isLoggedIn {
            // 사용자 정보 복원 시도
        if AuthManager.shared.getUser() != nil {
            let savedUser = AuthManager.shared.getUser()!
            self.currentUser = savedUser
            let userInfo = "이메일: \(savedUser.email), 닉네임: \(savedUser.nickname)"
            Logger.log(.info, category: Logger.auth, message: "기존 사용자 세션 복원 성공: \(userInfo)")
        } else {
            // 토큰은 있지만 사용자 정보가 없는 경우
            Logger.log(.error, category: Logger.auth, message: "토큰은 있으나 사용자 정보 없음. 사용자 세션 초기화")
            AuthManager.shared.clearToken() // 불완전한 상태이므로 토큰도 제거
            self.isLoggedIn = false
        }
        }
    }
    
    // MARK: - 게스트모드 관련 메소드
    
    // 게스트 로그인 처리
    @MainActor
    func loginAsGuest() {
        // 기존 로그인 정보 초기화
        self.currentUser = nil
        self.isLoggedIn = false
        
        // 게스트 모드 활성화
        self.isGuestMode = true
        
        Logger.log(.info, category: Logger.auth, message: "게스트 모드로 로그인")
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
            
            // 응답 정보 유효성 확인
            guard !response.token.isEmpty, response.user.email.count > 0, response.user.nickname.count > 0 else {
                self.errorMessage = "서버에서 올바른 사용자 정보를 받지 못했습니다"
                self.isLoading = false
                Logger.log(.error, category: Logger.auth, message: "로그인 응답 데이터 불완전: \(response)")
                return false
            }
            
            // JWT 토큰과 사용자 정보 저장
            AuthManager.shared.saveToken(response.token)
            AuthManager.shared.saveUser(response.user)
            
            // 상태 업데이트
            self.currentUser = response.user
            self.isLoggedIn = true
            self.isLoading = false
            
            Logger.log(.info, category: Logger.auth, message: "로그인 성공: \(email), 닉네임: \(response.user.nickname)")
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
        
        do {
            let response: SocialLoginResponse
            
            // 소셜 로그인 제공자에 따라 적절한 API 호출
            switch provider {
            case .google:
                response = try await UserService.shared.googleLogin(token: token)
            case .kakao:
                response = try await UserService.shared.kakaoLogin(token: token)
            case .naver:
                response = try await UserService.shared.naverLogin(token: token)
            case .apple:
                // Apple 로그인은 아직 서버 API가 준비되지 않은 것으로 가정
                self.errorMessage = "Apple 로그인은 아직 지원되지 않습니다"
                self.isLoading = false
                return false
            }
            
            // 응답 정보 유효성 확인
            guard
                let token = response.token?.trimmingCharacters(in: .whitespacesAndNewlines),
                !token.isEmpty,
                response.user.email.count > 0,
                response.user.nickname.count > 0
            else {
                Logger.log(.error, category: Logger.auth, message: "소셜 로그인 응답 데이터 불완전: \(response)")
                return false
            }
            
            // JWT 토큰과 사용자 정보 저장
            AuthManager.shared.saveToken(response.token ?? "nil")
            AuthManager.shared.saveUser(response.user)
            
            // 상태 업데이트
            self.currentUser = response.user
            self.isLoggedIn = true
            self.isLoading = false
            
            switch response.statusCode {
            case 200:
                self.shouldNavigateToMain = true
            case 201:
                self.shouldNavigateToSignUp = true
            default:
                Logger.log(.error, category: Logger.auth, message: "\(provider.rawValue) 로그인 응답 상태코드: \(String(describing: response.statusCode))")
            }
            
            Logger.log(.info, category: Logger.auth, message: "\(provider.rawValue) 로그인 성공: \(response.user.email)")
            return true
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            Logger.log(.error, category: Logger.auth, message: "\(provider.rawValue) 로그인 실패: \(error.localizedDescription)")
            return false
        } catch {
            self.errorMessage = "로그인 중 오류가 발생했습니다"
            self.isLoading = false
            Logger.log(.error, category: Logger.auth, message: "\(provider.rawValue) 로그인 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    // 로그아웃 처리 (게스트 모드도 종료)
    @MainActor
    func logout() {
        let userEmail = currentUser?.email ?? "Unknown"
        Logger.log(.info, category: Logger.auth, message: "로그아웃 요청: \(userEmail)")
        AuthManager.shared.logout()
        self.currentUser = nil
        self.isLoggedIn = false
        self.isGuestMode = false
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
            Logger.log(.error, category: Logger.auth, message: "토큰 형식이 올바르지 않음")
            return false
        }
        
        // 토큰 만료 시간이 현재보다 미래인지 확인
        let isValid = Date(timeIntervalSince1970: expiration) > Date()
        if !isValid {
            Logger.log(.error, category: Logger.auth, message: "토큰이 만료됨")
        }
        return isValid
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

/// 소셜 로그인
enum SocialLoginProvider: String {
    case google = "Google"
    case apple = "Apple"
    case kakao = "Kakao"
    case naver = "Naver"
}
