//
//  AuthView.swift
//  CineHive
//
//  Created by 이종민 on 3/31/25.
//

import SwiftUI

// 로그인 전 초기화면
struct AuthView: View {
    @State private var showLogin = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                // 앱 로고
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("LoginBtnColor"))
                
                Text("CineHive")
                    .font(.system(size: 36, weight: .bold))
                
                Text("영화와 드라마의 모든 것을 한 곳에서")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                // 로그인 버튼
                Button {
                    showLogin = true
                } label: {
                    Text("로그인하기")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color("LoginBtnColor"))
                        .cornerRadius(12)
                }
                
                // 회원가입 링크
                NavigationLink(destination: SignUpView()) {
                    Text("새로운 계정 만들기")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("LoginBtnColor"))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("LoginBtnColor"), lineWidth: 1)
                        )
                }
                
                // 게스트 로그인
                Button {
                    // 게스트로 계속하기 로직
                } label: {
                    Text("게스트로 둘러보기")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 48)
            .fullScreenCover(isPresented: $showLogin) {
                LoginView()
            }
        }
    }
}

#Preview {
    AuthView()
}
