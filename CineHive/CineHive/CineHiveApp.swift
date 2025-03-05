//
//  CineHiveApp.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct CineHiveApp: App {
    init() {
        // Kakao SDK 초기화
        if let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: kakaoAppKey)
            print("Kakao App Key: \(kakaoAppKey)")
        } else {
            print("Kakao App Key 로드 실패")
        }
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
