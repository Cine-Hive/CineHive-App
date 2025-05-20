//
//  GoogleLoginBtnView.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import SwiftUI

struct GoogleLoginBtnView: View {
    @State private var viewModel = GoogleLoginViewModel()
    
    var body: some View {
        Button(action: {
            if let rootVC = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .first?.rootViewController {
                viewModel.login(presentingViewController: rootVC)
            }
        }, label: {
            HStack {
                Image("GoogleLogo")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: 3)
                Text("Google로 계속하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.black)
            }
            .frame(width: 330, height: 44)
            .background(Color("GoogleColor"))
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
