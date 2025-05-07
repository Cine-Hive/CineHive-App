//
//  KakaoLoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 4/10/25.
//

import Foundation
import UIKit
import OSLog
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@Observable
class KaKaoLoginViewModel {
    
    private let userService: UserService
    private let userState: UserState
    
    // 네비게이션 상태
    var shouldNavigateToMain: Bool = false
    var shouldNavigateToSignUp: Bool = false
    var toast: ToastState = ToastState()
    
    init(userService: UserService = .shared, userState: UserState = .shared) {
        self.userService = userService
        self.userState = userState
    }
    
    func login() {
        let loginHandler: (OAuthToken?, Error?) -> Void = { (oauthToken, error) in
            if let error = error {
                Logger.log(.error, category: Logger.auth, message: "카카오 로그인 실패: \(error.localizedDescription)")
                return
            }
            
            guard let token = oauthToken else {
                Logger.log(.error, category: Logger.auth, message: "OAuth 토큰 없음")
                return
            }
            
            Task {
                let result = await self.userState.socialLogin(provider: .kakao, token: token.accessToken)
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
        
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 앱 로그인
            UserApi.shared.loginWithKakaoTalk(completion: loginHandler)
        } else {
            // 카카오톡 웹 로그인
            UserApi.shared.loginWithKakaoAccount(completion: loginHandler)
        }
    }
}
