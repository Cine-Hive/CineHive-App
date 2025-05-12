//
//  NaverLoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 5/10/25.
//

import Foundation
import NaverThirdPartyLogin

@Observable
class NaverLoginViewModel: NSObject, UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate {
    private let userService: UserService
    private let userState: UserState
    
    var shouldNavigateToMain: Bool = false
    var shouldNavigateToSignUp: Bool = false
    var toast: ToastState = ToastState()

    init(userService: UserService = .shared, userState: UserState = .shared) {
        self.userService = userService
        self.userState = userState
    }
    
    //MARK: - 로그인 시도
    func login() {
        NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
        // 앱을 통한 로그인 & 브라우저를 통한 로그인이 모두 가능
        NaverThirdPartyLoginConnection
            .getSharedInstance()
            .requestThirdPartyLogin()
        
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
        userState.logout()
    }
    
    //MARK: - Error발생시
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(#fileID, #function, #line, "- naver login error: \(error.localizedDescription)")
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
            case .successNavigateToSignUp:
                // 회원가입 뷰로 이동 준비
                self.shouldNavigateToSignUp = true
            case .failure(let message):
                self.toast = ToastState(isShowing: true, message: message.message, type: .error)
            }
        }
    }
}
