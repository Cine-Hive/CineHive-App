//
//  LoginView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("로그인")
                    .font(.system(size: 25, weight: .bold))
                
                // 소셜 로그인 버튼 섹션
                VStack {
                    KakaoLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .kakao)
                            }
                        }
                    NaverLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .naver)
                            }
                        }
                    GoogleLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .google)
                            }
                        }
                    AppleLoginBtnView()
                        .onTapGesture {
                            Task {
                                await viewModel.socialLogin(provider: .apple)
                            }
                        }
                }
                .frame(width: 330, height: 250)
                
                Text("이메일로 로그인")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 330, height: 30, alignment: .leading)
                
                // 로그인 입력 필드
                VStack(spacing: 16) {
                    // 이메일 필드
                    TextField("이메일", text: $viewModel.email)
                        .padding()
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("FontColor"), lineWidth: 0.6)
                        )
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                    
                    // 비밀번호 필드
                    HStack {
                        if viewModel.showPassword {
                            TextField("비밀번호", text: $viewModel.password)
                        } else {
                            SecureField("비밀번호", text: $viewModel.password)
                        }
                        
                        Button(action: {
                            viewModel.showPassword.toggle()
                        }, label: {
                            Image(systemName: viewModel.showPassword ? "eye" : "eye.slash")
                                .foregroundStyle(.gray)
                        })
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("FontColor"), lineWidth: 0.6)
                    )
                }
                .frame(width: 330)
                
                // 오류 메시지
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .frame(width: 330, height: 20, alignment: .leading)
                        .padding(.top, 4)
                }
                
                if viewModel.shouldOfferEmailVerificationResend {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "envelope.badge")
                                .imageScale(.medium)
                            Text("이 계정은 이메일 인증이 필요해요. 메일함에서 인증 링크를 눌러 완료한 뒤 다시 로그인해주세요.")
                                .font(.system(size: 14))
                        }
                        Button {
                            Task { await viewModel.resendSignupVerification() }
                        } label: {
                            Text("인증 메일 재발송")
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.leading, 32)
                        }
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(uiColor: .systemYellow).opacity(0.15))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(uiColor: .systemYellow).opacity(0.5), lineWidth: 1)
                    )
                    .frame(width: 330, alignment: .leading)
                    .padding(.leading, 5)
                    .padding(.top, 8)
                }
                
                // 로그인 버튼
                Button {
                    Task {
                        await viewModel.login()
                    }
                } label: {
                    HStack {
                        if viewModel.isLoggingIn {
                            ProgressView()
                                .tint(.white)
                                .padding(.trailing, 8)
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
                .disabled(viewModel.isLoggingIn || viewModel.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                HStack {
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
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
            .padding(.horizontal, 16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color("FontColor"))
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateToHome) {
                MainTabView()
            }
        }
    }
}

#Preview {
    LoginView()
}
