//
//  HomeViewModel.swift
//  CineHive
//
//  Created by 이종민 on 4/8/25.
//

import Foundation
import Observation
import SwiftUI
import Supabase

@Observable
final class HomeViewModel {
    // 영화 데이터
    var movies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    var popularMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    
    // UI 상태
    var isLoading = false
    var isRefreshing = false
    var error: String?
    var showNotification = false
    var notificationMessage = "최신 OTT 정보가 업데이트 되었습니다"
    var selectedOTT: OTT = .netflix
    
    // 프로필 옵션 관련 상태
    var showProfileOptions = false
    var isSearchActive = false
    var searchText = ""
    var showErrorToast = false

    // 프로필 표시용 상태
    var profileName: String = ""
    var profileImageURLString: String?
    
    // 서비스
    private let movieService: MovieService
    private let userState: UserState
    
    init(movieService: MovieService = .shared, userState: UserState = .shared) {
        self.movieService = movieService
        self.userState = userState
        // Kakao/Supabase 인증 상태 변화 구독 및 초기 프로필 로드
        Task {
            let auth = SupabaseConfig.shared.client.auth
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
    
    // MARK: - 데이터 로딩 메소드
    
    @MainActor
    func loadInitialData() async {
        if movies.isEmpty {
            await fetchAllMovies()
            
            // 환영 메시지 표시
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.notificationMessage = "CineHive에 오신 것을 환영합니다! 다양한 OTT 콘텐츠를 탐색해보세요."
                withAnimation {
                    self.showNotification = true
                }
            }
        }
    }
    
    @MainActor
    func refreshContent() async {
        isRefreshing = true
        
        await fetchAllMovies()
        
        // 알림 메시지 업데이트
        notificationMessage = "OTT 콘텐츠 정보가 최신으로 업데이트되었습니다"
        isRefreshing = false
        
        // 알림 표시
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.showNotification = true
            }
        }
    }
    
    // 모든 영화 데이터 가져오기
    @MainActor
    private func fetchAllMovies() async {
        do {
            isLoading = true
            error = nil
            
            // 병렬로 영화 데이터 가져오기
            async let moviesTask = movieService.fetchMovies()
            async let nowPlayingTask = movieService.fetchNowPlayingMovies()
            async let popularTask = movieService.fetchPopularMovies()
            async let topRatedTask = movieService.fetchTopRatedMovies()
            async let upcomingTask = movieService.fetchUpcomingMovies()
            
            // 모든 태스크 대기
            let (movies, nowPlaying, popular, topRated, upcoming) = try await (
                moviesTask,
                nowPlayingTask,
                popularTask,
                topRatedTask,
                upcomingTask
            )
            
            // 결과 저장
            self.movies = movies
            self.nowPlayingMovies = nowPlaying
            self.popularMovies = popular
            self.topRatedMovies = topRated
            self.upcomingMovies = upcoming
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
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
                if let data = kakao.identityData as? [String: Any] {
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

    // MARK: - 프로필 관련 메소드
    
    // 프로필 버튼 탭 핸들러
    func handleProfileTap() {
        if userState.isLoggedIn || userState.isGuestMode {
            // 프로필 옵션 시트 표시
            showProfileOptions = true
        } else {
            // 로그인 필요 - 사용자에게 알림
            showNotificationWithMessage("로그인이 필요합니다")
            
            // 실제 앱에서는 여기서 로그인 화면으로 이동하거나
            // 탭바의 프로필 탭으로 이동할 수 있음
            showProfileOptions = true // 임시로 프로필 옵션 표시
        }
    }
    
    // 프로필 옵션 토글
    func toggleProfileOptions() {
        showProfileOptions.toggle()
    }
    
    // 검색 활성화 토글
    func toggleSearchActive() {
        withAnimation(.spring(duration: 0.3)) {
            isSearchActive.toggle()
        }
    }
    
    // 로그아웃 핸들러
    @MainActor
    func handleLogout() {
        Task {
            userState.logout()
            showProfileOptions = false
            showNotificationWithMessage("로그아웃 되었습니다")
        }
    }
    
    // 설정 메뉴 핸들러
    func handleSettingsTap() {
        // 설정 화면으로 이동 로직
        showProfileOptions = false
        showNotificationWithMessage("설정 화면으로 이동합니다")
    }
    
    // 내 활동 메뉴 핸들러
    func handleActivityTap() {
        // 내 활동 화면으로 이동 로직
        showProfileOptions = false
        showNotificationWithMessage("내 활동 화면으로 이동합니다")
    }
    
    // 찜한 영화 메뉴 핸들러
    func handleFavoritesTap() {
        // 찜한 영화 화면으로 이동 로직
        showProfileOptions = false
        showNotificationWithMessage("찜한 영화 화면으로 이동합니다")
    }
    
    // MARK: - 알림 제어 메소드
    
    func dismissNotification() {
        showNotification = false
    }
    
    func showNotificationWithMessage(_ message: String) {
        notificationMessage = message
        showNotification = true
    }
    
    // MARK: - OTT 관련 메소드
    
    func selectOTT(_ ott: OTT) {
        selectedOTT = ott
    }
    
    // MARK: - 오류 처리 메소드
    
    func handleErrorChange() {
        if let errorMsg = error, !errorMsg.isEmpty {
            showErrorToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.showErrorToast = false
                    self.clearError()
                }
            }
        }
    }
    
    func clearError() {
        error = nil
    }
}
