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
    var toast: ToastState = ToastState()
    
    init(userService: UserService = .shared, userState: UserState = .shared) {
        self.userService = userService
        self.userState = userState
    }
    
    // Google 로그인 플로우를 시작하고 로그인 처리
    func login(presentingViewController: UIViewController) {
        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String else {
            self.toast = ToastState(isShowing: true, message: "Google Client ID를 불러올 수 없습니다.", type: .error)
            return
        }

        let scopes = [
            "https://www.googleapis.com/auth/userinfo.profile",
            "https://www.googleapis.com/auth/userinfo.email"
        ]

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController,
            hint: nil,
            additionalScopes: scopes
        ) { [weak self] result, error in
            guard let self else { return }

            if let error = error {
                self.toast = ToastState(isShowing: true, message: "Google 로그인 중 오류 발생: \(error.localizedDescription)", type: .error)
                return
            }

            guard let signInResult = result else {
                self.toast = ToastState(isShowing: true, message: "Google 로그인 결과가 없습니다.", type: .error)
                return
            }

            self.refreshGoogleTokenAndLogin(signInResult: signInResult)
        }
    }

    // 사용자 토큰 새로고침하고 로그인 처리
    private func refreshGoogleTokenAndLogin(signInResult: GIDSignInResult) {
        Task { [weak self] in
            guard let self else { return }
            
            var retryCount = 0
            let maxRetries = 3

            while retryCount < maxRetries {
                let (fetchedUser, fetchError) = await self.refreshGoogleUser(signInResult.user)

                if let error = fetchError {
                    retryCount += 1
                    if retryCount >= maxRetries {
                        self.toast = ToastState(isShowing: true, message: "Google 토큰 갱신 실패: \(error.localizedDescription)", type: .error)
                        return
                    }
                    continue
                }

                guard let user = fetchedUser else {
                    retryCount += 1
                    if retryCount >= maxRetries {
                        self.toast = ToastState(isShowing: true, message: "Google 사용자 정보를 가져올 수 없습니다.", type: .error)
                        return
                    }
                    continue
                }

                guard let idToken = user.idToken?.tokenString else {
                    self.toast = ToastState(isShowing: true, message: "Google 로그인 토큰이 유효하지 않습니다.", type: .error)
                    return
                }

                let result = await self.userState.socialLogin(provider: .google, token: idToken)
                switch result {
                case .successNavigateToMain:
                    self.shouldNavigateToMain = true
                case .failure(let message):
                    self.toast = ToastState(isShowing: true, message: message.message, type: .error)
                }
                return
            }

            self.toast = ToastState(isShowing: true, message: "Google 토큰 갱신이 반복 실패했습니다.", type: .error)
        }
    }
    
    private func refreshGoogleUser(_ user: GIDGoogleUser) async -> (GIDGoogleUser?, Error?) {
        await withCheckedContinuation { continuation in
            user.refreshTokensIfNeeded { refreshedUser, error in
                continuation.resume(returning: (refreshedUser, error))
            }
        }
    }
}
