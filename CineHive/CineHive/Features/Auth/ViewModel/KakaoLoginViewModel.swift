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
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 앱을 통한 로그인
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    Logger.log(.error, category: Logger.auth, message: "카카오톡 로그인 실패: \(error.localizedDescription)")
                } else if let token = oauthToken {
                    Task {
                        do {
                            let response = try await self.userService.kakaoLogin(token: token.accessToken)
                        } catch {
                            print("서버 로그인 실패: \(error.localizedDescription)")
                        }
                    }           
                    self.getUserInfo()
                }
            }
        } else {
            // 카카오 계정으로 로그인 (웹뷰 방식)
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    Logger.log(.error, category: Logger.auth, message: "카카오톡 로그인 실패: \(error.localizedDescription)")
                } else if let token = oauthToken {
                    Task {
                        do {
                            let response = try await self.userService.kakaoLogin(token: token.accessToken)
                            // 로그인 성공 후 응답 상태코드에 따라 분기
                            switch response.statusCode {
                            case 200:
                                if let token = response.token {
                                    self.shouldNavigateToMain = true
                                } else {
                                    print("기존 회원인데 토큰 없음")
                                }
                            case 201:
                                self.shouldNavigateToSignUp = true
                            default:
                                print("예상치 못한 상태 코드: \(String(describing: response.statusCode))")
                            }
                        } catch {
                            Logger.log(.error, category: Logger.auth, message:"서버 로그인 실패: \(error.localizedDescription)")
                        }
                    }
                    //self.getUserInfo()
                }
            }
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
