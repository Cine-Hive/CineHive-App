//
//  LoginView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @Bindable var router: AppRouter
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("로그인")
                    .font(.system(size: 25, weight: .bold))

                // 소셜 로그인
                VStack {
                    KakaoLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .kakao, router: router)
                            }
                        }
                    NaverLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .naver, router: router)
                            }
                        }
                    GoogleLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .google, router: router)
                            }
                        }
                    AppleLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .apple, router: router)
                            }
                        }
                }
                .frame(width: 330, height: 250)

                Text("이메일로 로그인")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 320, height: 30, alignment: .leading)

                // 이메일/비밀번호 입력
                VStack(spacing: 16) {
                    TextField("이메일", text: $viewModel.email)
                        .padding()
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color("FontColor"), lineWidth: 0.6))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    HStack {
                        if viewModel.showPassword {
                            TextField("비밀번호", text: $viewModel.password)
                        } else {
                            SecureField("비밀번호", text: $viewModel.password)
                        }

                        Button(action: { viewModel.showPassword.toggle() }) {
                            Image(systemName: viewModel.showPassword ? "eye" : "eye.slash")
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color("FontColor"), lineWidth: 0.6))
                }
                .frame(width: 330)

                // 오류 메시지
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .frame(width: 320, alignment: .leading)
                        .padding(.top, 4)
                }

                // 로그인 버튼
                Button {
                    Task {
                        await viewModel.login(router: router)
                    }
                } label: {
                    HStack {
                        if viewModel.isLoggingIn {
                            ProgressView().tint(.white).padding(.trailing, 8)
                        }
                        Text("로그인")
                    }
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 330, height: 50)
                    .background(Color("LoginBtnColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 16)
                .disabled(viewModel.isLoggingIn)

                HStack {
                    NavigationLink(destination: SignUpView(router: router)) {
                        Text("회원이 아니신가요?")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color("FontColor"))
                    }

                    Spacer()

                    NavigationLink(destination: Text("비밀번호 찾기 화면")) {
                        Text("비밀번호 찾기")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color("FontColor"))
                    }
                }
                .frame(width: 330)
                .padding(.top, 16)

                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        router.goToAuth()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color("FontColor"))
                    }
                }
            }
        }
    }
}
