//
//  ProfileViewModel.swift
//  CineHive
//
//  Created by 존진 on 10/14/25.
//

import Foundation
import SwiftUI
import Supabase

@Observable
final class ProfileViewModel {
    // MARK: - 상태
    var showProfileOptions = false
    var showErrorToast = false
    var showNotification = false
    var notificationMessage = ""
    var profileName: String = ""
    var profileImageURLString: String?
    
    // MARK: - 종속성
    private let userState: UserState
    
    init(userState: UserState = .shared) {
        self.userState = userState
        
        // 자동 프로필 동기화: 앱 시작/로그인/토큰 갱신 시
        Task {
            let auth = SupabaseConfig.shared.client.auth
            // 초기 세션이 있으면 곧바로 로드
            if (try? await auth.session) != nil {
                await self.loadProfileFromSupabase()
            }
            for await change in auth.authStateChanges {
                switch change.event {
                case .signedIn, .tokenRefreshed, .userUpdated, .initialSession:
                    await self.loadProfileFromSupabase()
                default:
                    break
                }
            }
        }
    }
    
    // MARK: - 프로필 액션
    func handleProfileTap() {
        if userState.isLoggedIn || userState.isGuestMode {
            showProfileOptions = true
        } else {
            showNotificationWithMessage("로그인이 필요합니다")
            showProfileOptions = true // 임시 표시
        }
    }
    
    func toggleProfileOptions() {
        showProfileOptions.toggle()
    }
    
    @MainActor
    func handleLogout() {
        Task {
            userState.logout()
            showProfileOptions = false
            showNotificationWithMessage("로그아웃 되었습니다")
        }
    }
    
    // MARK: - 알림 제어
    func dismissNotification() {
        showNotification = false
    }
    
    func showNotificationWithMessage(_ message: String) {
        notificationMessage = message
        showNotification = true
    }
    
    // MARK: - 프로필 로딩
    @MainActor
    func loadProfileFromSupabase() async {
        guard let session = try? await SupabaseConfig.shared.client.auth.session else {
            return
        }
        let user = session.user
        var nameCandidate: String?
        var imageCandidate: String?
        let nameKeys = ["nickname", "preferred_username", "full_name", "name", "user_name"]
        let imageKeys = ["avatar_url", "profile_image_url", "picture", "thumbnail_image_url"]
        
        if let meta = user.userMetadata as? [String: Any] {
            for k in nameKeys {
                if let v = coerceString(meta[k]), !v.isEmpty { nameCandidate = v; break }
            }
            for k in imageKeys {
                if let v = coerceString(meta[k]), !v.isEmpty { imageCandidate = v; break }
            }
        }
        
        if (nameCandidate == nil || imageCandidate == nil), let identities = user.identities {
            if let kakao = identities.first(where: { $0.provider == "kakao" }) {
                if let data = kakao.identityData {
                    if nameCandidate == nil {
                        for k in nameKeys {
                            if let v = coerceString(data[k]), !v.isEmpty { nameCandidate = v; break }
                        }
                    }
                    if imageCandidate == nil {
                        for k in imageKeys {
                            if let v = coerceString(data[k]), !v.isEmpty { imageCandidate = v; break }
                        }
                    }
                    if imageCandidate == nil {
                        let desc = String(describing: data)
                        if let url = extractFirstImageURL(in: desc) { imageCandidate = url }
                    }
                }
            }
        }
        
        if let img = imageCandidate, img.hasPrefix("http://") {
            imageCandidate = img.replacingOccurrences(of: "http://", with: "https://")
        }
        
        self.profileName = nameCandidate ?? (user.email ?? "")
        self.profileImageURLString = imageCandidate
    }
    
    // MARK: - Helpers (Profile)
    private func coerceString(_ value: Any?) -> String? {
        guard let value = value else { return nil }
        if let s = value as? String { return s }
        if let u = value as? URL { return u.absoluteString }
        if let n = value as? NSNumber { return n.stringValue }
        let s = String(describing: value)
        return s.isEmpty ? nil : s
    }
    
    private func extractFirstImageURL(in text: String) -> String? {
        let pattern = #"https?:\/\/[\w\-\.]*kakaocdn\.net[^\s\"]+|https?:\/\/[^\s\"]+\.(?:jpg|jpeg|png)"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else { return nil }
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        if let match = regex.firstMatch(in: text, options: [], range: range), let r = Range(match.range, in: text) {
            return String(text[r])
        }
        return nil
    }
}
