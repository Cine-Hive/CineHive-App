//
//  SignUpView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var viewModel = SignUpViewModel()
    var onSignUpSuccess: (() -> Void)? = nil
    
    @Bindable var router: AppRouter
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        Text("회원가입")
                            .frame(width: 320, height: 70)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.horizontal, 16)
                        
                        InputFieldView(title: "이메일", text: $viewModel.email)
                        
                        if let emailError = viewModel.emailErrorMessage {
                            Text(emailError)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                                .frame(width: 320, height: 20, alignment: .leading)
                        } else if let emailCheck = viewModel.emailCheckMessage {
                            Text(emailCheck)
                                .font(.system(size: 14))
                                .foregroundColor(emailCheck == "사용 가능한 이메일입니다." ? .green : .red)
                                .frame(width: 330, alignment: .leading)
                        }
                        
                        PasswordFieldView(title: "비밀번호", text: $viewModel.password, showPassword: $viewModel.showPassword)
                        InputFieldView(title: "닉네임", text: $viewModel.nickname)
                        
                        if let nicknameError = viewModel.nicknameErrorMessage {
                            Text(nicknameError)
                                .font(.system(size: 14))
                                .foregroundColor(nicknameError == "사용 가능한 닉네임입니다." ? .green : .red)
                                .frame(width: 330, alignment: .leading)
                                .padding(.top, 1)
                        }
                        
                        InputFieldView(title: "이름", text: $viewModel.name, isRequired: false)
                        GenderSelectedView(selectedGender: $viewModel.gender)
                        
                        Button(action: {
                            Task {
                                await viewModel.signUp()
                            }
                        }, label: {
                            HStack {
                                if viewModel.isSigningUp {
                                    ProgressView()
                                        .tint(.white)
                                        .padding(.trailing, 8)
                                }
                                Text("회원가입")
                            }
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 330, height: 50)
                            .background(viewModel.isValid() ? Color("LoginBtnColor") : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        })
                        .padding(.top, 16)
                        .disabled(!viewModel.isValid() || viewModel.isSigningUp)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
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
            // 회원가입 성공 시 NavigationDestination로 SignUpCompleteView로 이동
            .navigationDestination(isPresented: $viewModel.isSignUpSuccess) {
                SignUpCompleteView(
                    nickname: viewModel.nickname,
                    onComplete: {
                        router.goToLogin()
                    }
                )
                .navigationBarBackButtonHidden(true)
            }
            .errorToast(
                message: viewModel.generalErrorMessage,
                isPresented: .init(
                    get: { viewModel.generalErrorMessage != nil },
                    set: { if !$0 { viewModel.generalErrorMessage = nil } }
                )
            )
        }
    }
}

struct InputFieldView: View {
    let title: String
    @Binding var text: String
    var isRequired: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                // isRequired가 true일 때만 * 표시
                if isRequired {
                    Text("*")
                        .font(.system(size: 20))
                        .foregroundStyle(.red)
                        .offset(x: -7)
                }
            }
            .frame(width: 320, height: 25, alignment: .leading)
            
            TextField("", text: $text)
                .frame(width: 300, height: 50)
                .textInputAutocapitalization(.never)    // 첫 글자 대문자 표출 X
                .frame(width: 330, height: 50)
                .overlay() {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("FontColor"), lineWidth: 0.6)
                }
        }
        .frame(width: 330, height: 90)
    }
}

struct PasswordFieldView: View {
    let title: String
    @Binding var text: String
    @Binding var showPassword: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                Text("*")
                    .font(.system(size: 20))
                    .foregroundStyle(.red)
                    .offset(x: -7)
            }
            .frame(width: 320, height: 25, alignment: .leading)
            
            HStack {
                Section {
                    if showPassword {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                }
                .frame(width: 260, height: 40)
                
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .padding(.trailing, 1)
                        .foregroundStyle(.gray)
                })
            }
            .frame(width: 330, height: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(Color("FontColor"), lineWidth: 0.6)
            }
        }
        .frame(width: 330, height: 90)
    }
}

struct GenderSelectedView: View {
    @Binding var selectedGender: String
    let genders: [String] = ["남자", "여자"]
    
    var body: some View {
        VStack {
            Text("성별")
                .frame(width: 320, height: 25, alignment: .leading)
                .font(.system(size: 17))
            
            HStack {
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        selectedGender = gender
                    }) {
                        Text(gender)
                            .foregroundColor(selectedGender == gender ? Color("LoginBtnColor") : Color("FontColor"))
                            .frame(width: 160, height: 50)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedGender == gender ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: 0.6)
                    )
                }
            }
        }
        .frame(width: 330, height: 90)
    }
}
