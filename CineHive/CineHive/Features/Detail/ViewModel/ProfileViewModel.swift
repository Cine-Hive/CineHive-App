//
//  ProfileViewModel.swift
//  CineHive
//
//  Created by 이종민 on 4/2/25.
//

import Foundation
import Observation
import SwiftUI
import OSLog

@Observable
class ProfileViewModel {
    // MARK: - 상태 관리
    
    // 로그인 상태
    var isLoggedIn: Bool = false
    
    // 사용자 정보
    var userInfo: UserInfo = UserInfo(id: 0, email: "", nickname: "")
    
    // 사용자 활동 통계
    var userBoardsCount: Int = 0
    var userCommentsCount: Int = 0
    var userLikesCount: Int = 0
    var userBookmarksCount: Int = 0
    var userFavoriteMoviesCount: Int = 0
    
    // 섹션별 데이터
    var userBoards: [Board] = []
    var userComments: [Comment] = []
    var userLikedPosts: [Board] = []
    var userBookmarks: [Board] = []
    var userFavoriteMovies: [Movie] = []
    
    // 섹션별 로딩 상태
    var isLoadingBoards: Bool = false
    var isLoadingComments: Bool = false
    var isLoadingLikedPosts: Bool = false
    var isLoadingBookmarks: Bool = false
    var isLoadingFavoriteMovies: Bool = false
    
    // 설정 상태
    var isDarkMode: Bool = true
    var selectedLanguage: Language = .korean
    var pushNotificationsEnabled: Bool = true
    var emailNotificationsEnabled: Bool = false
    
    // 에러 처리
    var error: String? = nil
    var showErrorToast: Bool = false
    
    // 서비스 인스턴스
    private let boardService = BoardService.shared
    private let commentService = CommentService.shared
    private let movieService = MovieService.shared
    
    // MARK: - 초기화 및 로그인 상태 확인
    
    func checkLoginStatus() {
        // AuthManager를 통해 로그인 상태 확인
        if let token = AuthManager.shared.getToken() {
            isLoggedIn = true
            loadUserInfo()
        } else {
            isLoggedIn = false
            resetUserData()
        }
    }
    
    private func loadUserInfo() {
        // UserState에서 사용자 정보 가져오기
        if let currentUser = UserState.shared.currentUser {
            // UserData 객체에 id 속성이 없다면 0으로 대체하거나 적절한 값 사용
            userInfo = UserInfo(id: 0, email: currentUser.email, nickname: currentUser.nickname)
        } else {
            // UserState에 정보가 없는 경우 AuthManager를 통해 다시 로드 시도
            if let savedUser = AuthManager.shared.getUser() {
                // UserData 객체에 id 속성이 없다면 0으로 대체하거나 적절한 값 사용
                userInfo = UserInfo(id: 0, email: savedUser.email, nickname: savedUser.nickname)
                // UserState 업데이트
                UserState.shared.currentUser = savedUser
            }
        }
    }
    
    private func resetUserData() {
        // 사용자 데이터 초기화
        userInfo = UserInfo(id: 0, email: "", nickname: "")
        
        // 사용자 활동 데이터 초기화
        userBoards = []
        userComments = []
        userLikedPosts = []
        userBookmarks = []
        userFavoriteMovies = []
        
        // 통계 초기화
        userBoardsCount = 0
        userCommentsCount = 0
        userLikesCount = 0
        userBookmarksCount = 0
        userFavoriteMoviesCount = 0
    }
    
    // MARK: - 로그아웃
    
    @MainActor
    func logout() async {
        // 로그아웃 애니메이션 등을 위한 비동기 처리
        // UserState를 통해 로그아웃 처리
        UserState.shared.logout()
        
        // 상태 초기화
        isLoggedIn = false
        resetUserData()
    }
    
    // MARK: - 사용자 게시글 로드
    
    @MainActor
    func loadUserBoards() async {
        guard isLoggedIn else { return }
        
        isLoadingBoards = true
        error = nil
        
        do {
            // 실제로는 사용자 게시글만 필터링하는 API 엔드포인트를 사용해야 함
            let allBoards = try await boardService.fetchBoards()
            
            // 사용자 이메일로 필터링
            userBoards = allBoards.filter { $0.email == userInfo.email }
            userBoardsCount = userBoards.count
            
            isLoadingBoards = false
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            showErrorToast = true
            isLoadingBoards = false
            Logger.log(.error, category: Logger.ui, message: "게시글 로드 실패: \(networkError.errorDescription)")
        } catch {
            self.error = "게시글을 불러오는 중 오류가 발생했습니다."
            showErrorToast = true
            isLoadingBoards = false
            Logger.log(.error, category: Logger.ui, message: "게시글 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 사용자 댓글 로드
    
    @MainActor
    func loadUserComments() async {
        guard isLoggedIn else { return }
        
        isLoadingComments = true
        error = nil
        
        do {
            // 실제로는 사용자 댓글만 가져오는 API 엔드포인트가 필요함
            // 여기서는 이미 있는 댓글 API를 활용한다고 가정
            
            // 임시 데이터: 실제 구현 시 서버 API에 맞게 변경 필요
            userComments = []
            
            // 댓글을 가져오기 위해 여러 게시글의 댓글을 조회해야 할 수 있음
            for board in userBoards.prefix(5) { // 최근 5개 게시글만 처리
                let comments = try await commentService.fetchComments(boardId: board.id)
                // 사용자 이메일로 필터링
                let userFilteredComments = comments.filter { $0.email == userInfo.email }
                userComments.append(contentsOf: userFilteredComments)
            }
            
            userCommentsCount = userComments.count
            isLoadingComments = false
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            showErrorToast = true
            isLoadingComments = false
            Logger.log(.error, category: Logger.ui, message: "댓글 로드 실패: \(networkError.errorDescription)")
        } catch {
            self.error = "댓글을 불러오는 중 오류가 발생했습니다."
            showErrorToast = true
            isLoadingComments = false
            Logger.log(.error, category: Logger.ui, message: "댓글 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 사용자가 좋아요한 게시글 로드
    
    @MainActor
    func loadUserLikedPosts() async {
        guard isLoggedIn else { return }
        
        isLoadingLikedPosts = true
        error = nil
        
        do {
            // 실제로는 사용자가 좋아요한 게시글을 가져오는 API 엔드포인트가 필요함
            // 여기서는 서버에 해당 API가 없다고 가정하고 임시 데이터를 사용
            
            // 임시 데이터: 실제 구현 시 서버 API에 맞게 변경 필요
            let allBoards = try await boardService.fetchBoards()
            
            // 실제 API에서는 직접 사용자가 좋아요한 게시글만 가져올 것
            // 여기서는 임의로 최근 3개 게시글을 좋아요한 것으로 가정
            userLikedPosts = Array(allBoards.prefix(3))
            userLikesCount = userLikedPosts.count
            
            isLoadingLikedPosts = false
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            showErrorToast = true
            isLoadingLikedPosts = false
            Logger.log(.error, category: Logger.ui, message: "좋아요 게시글 로드 실패: \(networkError.errorDescription)")
        } catch {
            self.error = "좋아요한 게시글을 불러오는 중 오류가 발생했습니다."
            showErrorToast = true
            isLoadingLikedPosts = false
            Logger.log(.error, category: Logger.ui, message: "좋아요 게시글 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 사용자 북마크 게시글 로드
    
    @MainActor
    func loadUserBookmarks() async {
        guard isLoggedIn else { return }
        
        isLoadingBookmarks = true
        error = nil
        
        do {
            // 실제로는 사용자가 북마크한 게시글을 가져오는 API 엔드포인트가 필요함
            // 여기서는 서버에 해당 API가 없다고 가정하고 임시 데이터를 사용
            
            // 임시 데이터: 실제 구현 시 서버 API에 맞게 변경 필요
            let allBoards = try await boardService.fetchBoards()
            
            // 임의로 최근 2개 게시글을 북마크한 것으로 가정
            userBookmarks = Array(allBoards.prefix(2))
            userBookmarksCount = userBookmarks.count
            
            isLoadingBookmarks = false
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
            showErrorToast = true
            isLoadingBookmarks = false
            Logger.log(.error, category: Logger.ui, message: "북마크 게시글 로드 실패: \(networkError.errorDescription)")
        } catch {
            self.error = "북마크한 게시글을 불러오는 중 오류가 발생했습니다."
            showErrorToast = true
            isLoadingBookmarks = false
            Logger.log(.error, category: Logger.ui, message: "북마크 게시글 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 사용자 관심 영화 로드
    
    @MainActor
    func loadUserFavoriteMovies() async {
        guard isLoggedIn else { return }
        
        isLoadingFavoriteMovies = true
        error = nil
        
        do {
            // 실제로는 사용자가 관심 등록한 영화를 가져오는 API 엔드포인트가 필요함
            // 여기서는 서버에 해당 API가 없다고 가정하고 임시 데이터를 사용
            
            // 임시 데이터: 실제 구현 시 서버 API에 맞게 변경 필요
            // 여기서는 임의로 샘플 영화 데이터 생성
            
            userFavoriteMovies = Movie.dummyMovies
            userFavoriteMoviesCount = userFavoriteMovies.count
            
            isLoadingFavoriteMovies = false
        } catch {
            self.error = "관심 영화를 불러오는 중 오류가 발생했습니다."
            showErrorToast = true
            isLoadingFavoriteMovies = false
            Logger.log(.error, category: Logger.ui, message: "관심 영화 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 설정 관련 메소드
    
    func toggleDarkMode() {
        isDarkMode.toggle()
        // 실제로는 앱 전체의 테마를 변경하는 코드 필요
        Logger.log(.info, category: Logger.ui, message: "다크 모드 변경: \(isDarkMode ? "활성화" : "비활성화")")
    }
    
    func setLanguage(_ language: Language) {
        selectedLanguage = language
        // 실제로는 앱 언어 설정 변경 코드 필요
        Logger.log(.info, category: Logger.ui, message: "언어 설정 변경: \(language.displayName)")
    }
    
    func togglePushNotifications() {
        pushNotificationsEnabled.toggle()
        // 실제로는 푸시 알림 설정 변경 코드 필요
        Logger.log(.info, category: Logger.ui, message: "푸시 알림 설정 변경: \(pushNotificationsEnabled ? "활성화" : "비활성화")")
    }
    
    func toggleEmailNotifications() {
        emailNotificationsEnabled.toggle()
        // 실제로는 이메일 알림 설정 변경 코드 필요
        Logger.log(.info, category: Logger.ui, message: "이메일 알림 설정 변경: \(emailNotificationsEnabled ? "활성화" : "비활성화")")
    }
    
    // MARK: - 회원 탈퇴
    
    @MainActor
    func deleteAccount() async -> Bool {
        // 실제로는 서버 API를 통해 회원 탈퇴 처리
        // 여기서는 간단히 로그아웃만 수행
        await logout()
        Logger.log(.info, category: Logger.auth, message: "회원 탈퇴 처리 완료")
        return true
    }
    
    // MARK: - 프로필 편집
    
    @MainActor
    func updateProfile(nickname: String) async -> Bool {
        // 실제로는 서버 API를 통해 프로필 업데이트
        guard isLoggedIn else { return false }
        
        do {
            // 직접 nickname 업데이트
            userInfo.nickname = nickname
            
            // UserDefaults 업데이트 (임시)
            UserDefaults.standard.set(nickname, forKey: "userNickname")
            
            // UserState 업데이트
            if var currentUser = UserState.shared.currentUser {
                currentUser.nickname = nickname
                UserState.shared.currentUser = currentUser
                AuthManager.shared.saveUser(currentUser)
            }
            
            Logger.log(.info, category: Logger.auth, message: "프로필 업데이트 성공: \(nickname)")
            return true
        } catch {
            self.error = "프로필 업데이트 중 오류가 발생했습니다."
            showErrorToast = true
            Logger.log(.error, category: Logger.auth, message: "프로필 업데이트 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    func clearError() {
        error = nil
        showErrorToast = false
    }
}

// 사용자 정보 모델
struct UserInfo {
    let id: Int
    let email: String
    var nickname: String
}

// 언어 설정
enum Language: String, CaseIterable, Identifiable {
    case korean = "ko"
    case english = "en"
    case japanese = "ja"
    case chinese = "zh"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .korean: return "한국어"
        case .english: return "English"
        case .japanese: return "日本語"
        case .chinese: return "中文"
        }
    }
}
