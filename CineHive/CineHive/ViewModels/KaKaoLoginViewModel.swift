//
//  KaKaoLoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 3/4/25.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class KaKaoLoginViewModel {
    func kakaologin() {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡으로 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오톡 로그인 success")
                    
                    // 추가작업
                    _ = oauthToken
                }
            }
        } else {
            // 카카오계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오계정 로그인 success")
                    
                    // 추가작업
                    _ = oauthToken
                }
            }
        }
    }
}
