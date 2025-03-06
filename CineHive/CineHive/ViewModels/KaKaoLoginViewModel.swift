//
//  KaKaoLoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 3/4/25.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@Observable
class KaKaoLoginViewModel {
    
    private let userService: UserService
    
    init(userService: UserService = .shared) {
        self.userService = userService
    }
    
    @MainActor
    func kakaologin() async {
        do {
            guard let loginURL = try await userService.loginKakao() else {
                print("카카오 로그인 URL 생성 실패")
                return
            }
            
            print("카카오 로그인 URL: \(loginURL)")
            
            // 브라우저에서 카카오 로그인 페이지 열기
            await UIApplication.shared.open(loginURL)
            
        } catch {
            print("카카오 로그인 요청 실패: \(error.localizedDescription)")
        }
    }
}
