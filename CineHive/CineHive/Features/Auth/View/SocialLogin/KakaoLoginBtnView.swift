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
        NavigationStack {
            Button(action: {
                viewModel.login()
            }, label: {
                HStack {
                    Image("KakaoLogo")
                        .resizable()
                        .frame(width: 18, height: 18)
                    Text("카카오로 계속하기")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.black)
                }
                .frame(width: 330, height: 44)
                .background(Color("KakaoColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            })
            
            .fullScreenCover(isPresented: $viewModel.shouldNavigateToMain) {
                MainTabView()
            }
            .fullScreenCover(isPresented: $viewModel.shouldNavigateToSignUp) {
                SignUpView()
            }
        }
        
    }
}
