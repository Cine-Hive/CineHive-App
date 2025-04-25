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

    
    var shouldNavigateToMain: Bool = false
    var shouldNavigateToSignUp: Bool = false
    
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
                await self.userState.socialLogin(provider: .kakao, token: token.accessToken)
            }
        }
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk(completion: loginHandler)
        } else {
            UserApi.shared.loginWithKakaoAccount(completion: loginHandler)
        }
    }
    
    private func getUserInfo() {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                Logger.log(.info, category: Logger.state, message: "사용자 정보 가져오기 실패: \(error.localizedDescription)")
            } else {
                if let user = user {
                    print("id: \(user.id ?? 0)")
                    print("nickname: \(user.kakaoAccount?.profile?.nickname ?? "")")
                    print("email: \(user.kakaoAccount?.email ?? "")")
                }
            }
        }
    }
}
