//
//  AuthManager.swift
//  CineHive
//
//  Created by 이종민 on 3/30/25.
//

import Foundation
import Security
import OSLog

final class AuthManager {
    static let shared = AuthManager()
    
    private let userDefaultsUserKey = "cinehive_current_user"
    
    // 키체인 액세스 상수
    private let keychainService = "kr.co.Cine-Hive.CineHive.auth"
    private let tokenAccount = "authToken"
    
    private init() { }
    
    // MARK: - 토큰 관리
    
    /// 로그인 토큰을 안전하게 저장
    func saveToken(_ token: String) {
        // 키체인에 저장
        saveTokenToKeychain(token)
        Logger.log(.info, category: Logger.auth, message: "인증 토큰 저장됨")
    }
    
    /// 저장된 토큰 가져오기
    func getToken() -> String? {
        return getTokenFromKeychain()
    }
    
    /// 토큰 제거
    func clearToken() {
        deleteTokenFromKeychain()
        Logger.log(.info, category: Logger.auth, message: "인증 토큰 제거됨")
    }
    
    // MARK: - 키체인 관련 메서드
    
    private func saveTokenToKeychain(_ token: String) {
        guard let tokenData = token.data(using: .utf8) else {
            Logger.log(.error, category: Logger.auth, message: "토큰을 데이터로 변환 실패")
            return
        }
        
        // 기존 항목 삭제
        deleteTokenFromKeychain()
        
        // 키체인 쿼리 생성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: tokenAccount,
            kSecValueData as String: tokenData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        // 키체인에 저장
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            Logger.log(.error, category: Logger.auth, message: "키체인 토큰 저장 실패: \(status)")
        }
    }
    
    private func getTokenFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: tokenAccount,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            if status != errSecItemNotFound {
                Logger.log(.error, category: Logger.auth, message: "키체인 토큰 검색 실패: \(status)")
            }
            return nil
        }
    }
    
    private func deleteTokenFromKeychain() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: tokenAccount
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    // MARK: - 사용자 정보 관리
    
    /// 사용자 정보 로컬 저장
    func saveUser(_ userData: UserData) {
        do {
            // 빈 닉네임이나 이메일이 있는지 확인
            guard !userData.email.isEmpty, !userData.nickname.isEmpty else {
                Logger.log(.error, category: Logger.auth, message: "유효하지 않은 사용자 정보 저장 시도: 이메일 또는 닉네임이 비어 있음")
                return
            }
            
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(userData)
            UserDefaults.standard.set(encoded, forKey: userDefaultsUserKey)
            Logger.log(.info, category: Logger.auth, message: "사용자 정보 저장됨: \(userData.nickname)")
        } catch {
            Logger.log(.error, category: Logger.auth, message: "사용자 정보 인코딩 실패: \(error.localizedDescription)")
        }
    }
    
    /// 로컬에 저장된 사용자 정보 가져오기
    func getUser() -> UserData? {
        guard let userData = UserDefaults.standard.data(forKey: userDefaultsUserKey) else {
            Logger.log(.info, category: Logger.auth, message: "저장된 사용자 정보 없음")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(UserData.self, from: userData)
            
            // 필수 필드 검증
            guard !user.email.isEmpty, !user.nickname.isEmpty else {
                Logger.log(.info, category: Logger.auth, message: "복원된 사용자 정보에 필수 필드 누락")
                return nil
            }
            
            return user
        } catch {
            Logger.log(.error, category: Logger.auth, message: "사용자 정보 디코딩 실패: \(error.localizedDescription)")
            // 손상된 데이터는 제거
            clearUser()
            return nil
        }
    }
    
    /// 사용자 정보 제거
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: userDefaultsUserKey)
        Logger.log(.info, category: Logger.auth, message: "사용자 정보 제거됨")
    }
    
    // MARK: - 로그인 상태 확인
    
    /// 사용자 로그인 상태 확인
    var isLoggedIn: Bool {
        return getToken() != nil
    }
    
    // MARK: - 통합 로그아웃 메소드
    
    func logout() {
        clearToken()
        clearUser()
    }
    // MARK: - 디버깅

    /// 키체인에 저장된 토큰 값을 로그로 출력 (디버깅용)
    func debugPrintToken() {
        if let token = getToken() {
            Logger.log(.info, category: Logger.auth, message: "키체인에 저장된 토큰: \(token)")
        } else {
            Logger.log(.info, category: Logger.auth, message: "키체인에 저장된 토큰 없음")
        }
    }
}
