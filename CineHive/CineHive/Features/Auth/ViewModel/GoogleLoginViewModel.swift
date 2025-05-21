//
//  GoogleLoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 5/20/25.
//

import Foundation
import GoogleSignIn
import SwiftUI

@Observable
class GoogleLoginViewModel {
    
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
    
    func login(presentingViewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error = error {
                self.toast = ToastState(isShowing: true, message: "Google 로그인 중 오류 발생: \(error.localizedDescription)", type: .error)
                return
            }
            guard let signInResult = signInResult else {
                self.toast = ToastState(isShowing: true, message: "Google 로그인 결과가 없습니다.", type: .error)
                return
            }

            signInResult.user.refreshTokensIfNeeded { user, error in
                if let error = error {
                    self.toast = ToastState(isShowing: true, message: "Google 토큰 갱신 실패: \(error.localizedDescription)", type: .error)
                    return
                }
                guard let user = user else {
                    self.toast = ToastState(isShowing: true, message: "Google 사용자 정보를 가져올 수 없습니다.", type: .error)
                    return
                }

                guard let idToken = user.idToken?.tokenString else {
                    // 토큰이 없으면 로그인 실패 처리
                    self.toast = ToastState(isShowing: true, message: "Google 로그인 토큰이 유효하지 않습니다.", type: .error)
                    return
                }
                
                Task {
                    let result = await self.userState.socialLogin(provider: .google, token: idToken)
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
    }
}
