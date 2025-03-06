//
//  KakaoLoginBtnView.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import SwiftUI
import KakaoSDKUser

struct KakaoLoginBtnView: View {
    
    @State private var viewModel = KaKaoLoginViewModel()
    
    var body: some View {
        Button(action: {
            // 카카오톡 실행 가능 여부 확인
            if UserApi.isKakaoTalkLoginAvailable() {
                // 카카오톡 로그인
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
                // 카카오계정 로그인
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error = error {
                        print(error)
                    } else {
                        Task {
                            await viewModel.kakaologin()
                        }
                        print("카카오계정 로그인 success")
                        // 추가작업
                        _ = oauthToken
                    }
                }
            }
        }, label: {
            HStack {
                Image("KakaoLogo")
                    .resizable()
                    .frame(width: 18, height: 18)
                Text("Kakao로 계속하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.black)
            }
            .frame(width: 330, height: 44)
            .background(Color("KakaoColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        })
    }
}
