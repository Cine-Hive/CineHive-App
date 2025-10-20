//
//  NaverLoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 5/10/25.
//

import Foundation
import NaverThirdPartyLogin
import OSLog

/// NOTE:
/// 네이버 로그인을 Supabase 백엔드에서 지원하지 않아 앱 정책으로 기능을 비활성화했습니다.
/// - 남겨둔 ViewModel은 빌드 에러 방지용이며, 호출 시 토스트만 노출하고 바로 반환합니다.
@Observable
class NaverLoginViewModel: NSObject, UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate {
    private let userService: UserService
    private let userState: UserState
    
    var shouldNavigateToMain: Bool = false
    var toast: ToastState = ToastState()

    init(userService: UserService = .shared, userState: UserState = .shared) {
        self.userService = userService
        self.userState = userState
    }
    
    //MARK: - 로그인 시도
    func login() {
        // Naver login is intentionally disabled (Supabase 미지원 정책)
        self.toast = ToastState(
            isShowing: true,
            message: "네이버 로그인은 더 이상 지원하지 않습니다.",
            type: .warning
        )
        Logger.log(.info, category: Logger.auth, message: "Naver login blocked by policy (Supabase unsupported)")
        return
    }
    
    //MARK: - 토큰 발급 성공
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        guard let token = NaverThirdPartyLoginConnection.getSharedInstance()?.accessToken else { return }
        handleAccessToken(token)
    }
    
    //MARK: - 토큰 갱신시
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        guard let token = NaverThirdPartyLoginConnection.getSharedInstance()?.accessToken else { return }
        handleAccessToken(token)
    }
    
    //MARK: - 로그아웃(토큰 삭제)시
    func oauth20ConnectionDidFinishDeleteToken() {
        // 이미 userState에서 로그아웃 처리
    }
    
    //MARK: - Error발생시
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        Logger.log(.error, category: Logger.auth, message: "- naver login error: \(error.localizedDescription)")
    }
}

private extension NaverLoginViewModel {
    func handleAccessToken(_ token: String) {
        Task {
            let result = await userState.socialLogin(provider: .naver, token: token)
            switch result {
            case .successNavigateToMain:
                // MainTabView로 이동 준비
                self.shouldNavigateToMain = true
            case .failure(let message):
                self.toast = ToastState(isShowing: true, message: message.message, type: .error)
            }
        }
    }
}
