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
import Supabase

@Observable
class KaKaoLoginViewModel {
    
    private let userService: UserService
    private let userState: UserState
    private let supabase = SupabaseConfig.shared.client
    
    // 네비게이션 상태
    var shouldNavigateToMain: Bool = false
    var toast: ToastState = ToastState()
    
    init(userService: UserService = .shared, userState: UserState = .shared) {
        self.userService = userService
        self.userState = userState
    }
    
    func login() {
        Task {
            do {
                try await supabase.auth.signInWithOAuth(
                    provider: .kakao,
                    redirectTo: URL(string: SupabaseConfig.Auth.appRedirect)
                )
                
            } catch {
                Logger.log(.error, category: Logger.auth, message: "카카오 로그인 실패: \(error.localizedDescription)")
                self.toast = ToastState(isShowing: true, message: "카카오 로그인에 실패했어요. 잠시 후 다시 시도해주세요.", type: .error)
            }
        }
    }
}
