//
//  CineHiveApp.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin
import GoogleSignIn
import OSLog
import Supabase

@main
struct CineHiveApp: App {
    @State private var userState = UserState.shared
    
    init() {
        // Kakao SDK 초기화
        if let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        }
        
        // 네이버 앱으로 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
        
        // 네이버 로그인 세로모드 고정
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        
        let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        let info = Bundle.main.infoDictionary

        naverInstance?.serviceUrlScheme = info?["NAVER_URL_SCHEME"] as? String
        naverInstance?.consumerKey = info?["NAVER_CLIENT_ID"] as? String
        naverInstance?.consumerSecret = info?["NAVER_CLIENT_SECRET"] as? String
        naverInstance?.appName = info?["NAVER_APP_NAME"] as? String
    }
    
    var body: some Scene {
        WindowGroup {
            // onOpenURL()을 사용해 커스텀 URL 스킴 처리
            ContentView().onOpenURL(perform: { url in
                if let appScheme = URL(string: SupabaseConfig.Auth.appRedirect)?.scheme,
                   url.scheme == appScheme {
                    Task {
                        do {
                            try await SupabaseConfig.shared.client.auth.session(from: url)
                            Logger.log(.info, category: Logger.auth, message: "Supabase OAuth 세션 설정 완료: \(url)")
                        } catch {
                            print("[OAuth] session(from:) error:", error)
                        }
                    }
                } else if AuthApi.isKakaoTalkLoginUrl(url) {
                    // Kakao 로그인 URL (SDK 직접 사용 시)
                    AuthController.handleOpenUrl(url: url)
                } else if url.scheme == (Bundle.main.object(forInfoDictionaryKey: "NAVER_URL_SCHEME") as? String),
                          (url.host == "oauth" || url.host == "thirdPartyLoginResult") {
                    // Naver 로그인 URL (앱/브라우저 콜백 모두 처리)
                    NaverThirdPartyLoginConnection.getSharedInstance()?.receiveAccessToken(url)
                } else if url.scheme?.hasPrefix("com.googleusercontent.apps") == true {
                    // Google 로그인 URL
                    _ = GIDSignIn.sharedInstance.handle(url)
                } else {
                    print("[OAuth] Unhandled URL:", url.absoluteString)
                    Logger.log(.info, category: Logger.auth, message: "처리되지 않은 URL: \(url)")
                }
            })
            .environment(userState)
        }
    }
}
