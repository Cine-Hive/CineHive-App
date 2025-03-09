//
//  KeychainManager.swift
//  CineHive
//
//  Created by 존진 on 3/6/25.
//

import Foundation
import Security

final class KeychainManager {
    static let shared = KeychainManager()
        private init() {}

        // 저장
        func saveToken(_ token: String, forKey key: String) {
            guard let data = token.data(using: .utf8) else { return }

            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            
            if status == errSecSuccess {
                print("키체인에 토큰 저장 완료")
            } else {
                print("키체인 저장 실패: \(status)")
            }
        }

        // 불러오기
        func loadToken(forKey key: String) -> String? {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecReturnData as String: true,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]

            var dataTypeRef: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

            if status == errSecSuccess, let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
}
