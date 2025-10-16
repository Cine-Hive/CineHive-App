//
//  GoogleLoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 5/20/25.
//

import Foundation
import GoogleSignIn
import SwiftUI
import Supabase
import UIKit

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
    
    @MainActor
    func googleSignIn(from presenting: UIViewController) async {
        do {
            // 1) Google 네이티브 로그인
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presenting)

            // 2) 토큰 추출
            guard let idToken = result.user.idToken?.tokenString else {
                self.toast = ToastState(isShowing: true, message: "Google ID 토큰을 가져올 수 없습니다.", type: .error)
                return
            }
            let accessToken = result.user.accessToken.tokenString

            // 3) Supabase Auth로 토큰 전달 → 세션 생성
            try await SupabaseManager.shared.auth.signInWithIdToken(
                credentials: OpenIDConnectCredentials(
                    provider: .google,
                    idToken: idToken,
                    accessToken: accessToken
                )
            )

            // 4) 성공 시 내비게이션 트리거
            self.shouldNavigateToMain = true
        } catch {
            self.toast = ToastState(isShowing: true, message: "Google 로그인 중 오류: \(error.localizedDescription)", type: .error)
        }
    }
}
