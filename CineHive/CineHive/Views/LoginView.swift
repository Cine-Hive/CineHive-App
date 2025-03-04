//
//  LoginView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("LOGIN")
                    .font(.system(size: 25, weight: .bold))
                VStack {
                    KakaoLoginBtnView()
                    GoogleLoginBtnView()
                    NaverLoginBtnView()
                    AppleLoginBtnView()
                }
                .frame(width: 330, height: 250)
                
                Text("or use your account")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 320, height: 30, alignment: .leading)
                
                Section {
                    TextField("Email", text: $viewModel.email)
                        .frame(width: 300, height: 50)
                        .textInputAutocapitalization(.never)    // 첫 글자 대문자 표출 X
                    HStack {
                        if viewModel.showPassword {
                            TextField("Password", text: $viewModel.password)
                        } else {
                            SecureField("Password", text: $viewModel.password)
                        }
                        Button(action: {
                            viewModel.showPassword.toggle()
                        }, label: {
                            Image(systemName: viewModel.showPassword ? "eye" : "eye.slash")
                                .foregroundStyle(.gray)
                        })
                    }
                    .frame(width: 300, height: 50)
                }
                .frame(width: 330, height: 50)
                .overlay() {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("FontColor"), lineWidth: 0.6)
                }
                
                // 오류 메시지
                if let emailError = viewModel.errorMessage {
                    Text(emailError)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .frame(width: 320, height: 20, alignment: .leading)
                }
                
                Button(action: {
                    Task {
                        await viewModel.login()
                    }
                }, label: {
                    Text("로그인")
                })
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 330, height: 50)
                .background(Color("LoginBtnColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack {
                    NavigationLink(destination: SignUpView()) {
                        Text("회원이 아니신가요?")
                    }
                    .frame(width: 160, height: 50, alignment: .leading)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color("FontColor"))
                    
                    // View 변경 필요
                    NavigationLink(destination: SignUpView()) {
                        Text("비밀번호 찾기")
                    }
                    .frame(width: 160, height: 50, alignment: .trailing)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color("FontColor"))
                }
                .frame(width: 330, height: 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
