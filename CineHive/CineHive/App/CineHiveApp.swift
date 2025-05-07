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
    @State private var userState = UserState.shared
    
    init() {
        // Kakao SDK 초기화
        if let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            // onOpenURL()을 사용해 커스텀 URL 스킴 처리
            ContentView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
            .environment(userState)
        }
    }
}
