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
    
    var shouldNavigateToMain: Bool = false
    var shouldNavigateToSignUp: Bool = false
    
    init(userService: UserService = .shared) {
        self.userService = userService
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
                do {
                    let response = try await self.userService.kakaoLogin(token: token.accessToken)
                    
                    // 토큰 저장 및 디버깅
                    if let token = response.token {
                        AuthManager.shared.saveToken(token)
                    }
                    AuthManager.shared.debugPrintToken()
                    
                    // 상태 코드에 따라 화면 전환 분기
                    switch response.statusCode {
                    case 200:
                        self.shouldNavigateToMain = true
                    case 201:
                        self.shouldNavigateToSignUp = true
                    default:
                        print("예상치 못한 상태 코드: \(String(describing: response.statusCode))")
                    }
                } catch {
                    Logger.log(.error, category: Logger.auth, message: "서버 로그인 실패: \(error.localizedDescription)")
                }
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
