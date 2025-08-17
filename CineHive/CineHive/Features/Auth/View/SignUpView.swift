//
//  SignUpView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

enum SignUpFocusField: Hashable {
    case email
    case password
    case confirmPassword
    case nickname
    case name
}

struct SignUpView: View {
    @State private var viewModel = SignUpViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: SignUpFocusField?
    var onSignUpSuccess: (() -> Void)? = nil

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        Text("회원가입")
                            .frame(width: 320, height: 70)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.horizontal, 16)
                        
                        ValidatedInputField(
                            title: "이메일",
                            text: $viewModel.email,
                            onCheckDuplicate: { await viewModel.checkEmailWithFormatValidation() },
                            focus: $focusedField,
                            field: .email
                        )

                        if let formatMessage = viewModel.emailFormatInvalidMessage {
                            Text(formatMessage)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                                .frame(width: 325, alignment: .leading)
                        }

                        if !viewModel.email.isEmpty, let emailCheck = viewModel.emailCheckMessage {
                            Text(emailCheck)
                                .font(.system(size: 14))
                                .foregroundColor(emailCheck == "사용 가능한 이메일입니다." ? .green : .red)
                                .frame(width: 330, alignment: .leading)
                        }
                        
                        PasswordFieldView(title: "비밀번호", text: $viewModel.password, showPassword: $viewModel.showPassword, focus: $focusedField, field: .password)
                        
                        if focusedField != .password, let errorMessage = viewModel.passwordErrorMessage {
                            Text(errorMessage)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                                .frame(width: 325, alignment: .leading)
                        }
                        
                        PasswordFieldView(title: "비밀번호 확인", text: $viewModel.confirmPassword, showPassword: $viewModel.showPassword, focus: $focusedField, field: .confirmPassword)
                        
                        if focusedField != .confirmPassword, !viewModel.confirmPassword.isEmpty && viewModel.password != viewModel.confirmPassword {
                            Text("비밀번호가 일치하지 않습니다.")
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                                .frame(width: 325, alignment: .leading)
                        }
                        
                        ValidatedInputField(
                            title: "닉네임",
                            text: $viewModel.nickname,
                            onCheckDuplicate: { await viewModel.checkValidateNickname() },
                            focus: $focusedField,
                            field: .nickname
                        )
                        
                        if let nicknameCheck = viewModel.nicknameCheckMessage {
                            Text(nicknameCheck)
                                .font(.system(size: 14))
                                .foregroundColor(nicknameCheck == "사용 가능한 닉네임입니다." ? .green : .red)
                                .frame(width: 325, alignment: .leading)
                                .padding(.top, 1)
                        }
                        
                        InputFieldView(title: "이름", text: $viewModel.name, focus: $focusedField, field: .name)
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
                        .disabled(!viewModel.isValid() || viewModel.isSigningUp || viewModel.password != viewModel.confirmPassword)
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
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color("FontColor"))
                    }
                }
            }
            // 회원가입 성공 시 NavigationDestination로 SignUpCompleteView로 이동
            .navigationDestination(isPresented: $viewModel.isSignUpSuccess) {
                // onSignUpSuccess를 전달하여 SignUpCompleteView가 완료 시 이를 호출하도록 함
                SignUpCompleteView(nickname: viewModel.nickname, onComplete: {
                    dismiss()
                    onSignUpSuccess?()
                })
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

#Preview {
    SignUpView(onSignUpSuccess: nil)
}

struct InputFieldView: View {
    let title: String
    @Binding var text: String
    var focus: FocusState<SignUpFocusField?>.Binding
    let field: SignUpFocusField
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 17))
            }
            .frame(width: 320, height: 25, alignment: .leading)
            
            TextField("", text: $text)
                .focused(focus, equals: field)
                .frame(width: 300, height: 50)
                .textInputAutocapitalization(.never)    // 첫 글자 대문자 표출 X
                .frame(width: 330, height: 50)
                .background(focus.wrappedValue == field ? Color("LoginBtnColor").opacity(0.06) : .clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(focus.wrappedValue == field ? Color("LoginBtnColor") : Color("FontColor"),
                                lineWidth: focus.wrappedValue == field ? 1.2 : 0.6)
                        .animation(.easeInOut(duration: 0.15), value: focus.wrappedValue == field)
                }
        }
        .frame(width: 330, height: 90)
    }
}

struct PasswordFieldView: View {
    let title: String
    @Binding var text: String
    @Binding var showPassword: Bool
    var focus: FocusState<SignUpFocusField?>.Binding
    let field: SignUpFocusField
    
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
                            .focused(focus, equals: field)
                            .onChange(of: text) { newValue, _ in
                                if newValue.count > 20 { text = String(newValue.prefix(20)) }
                            }
                    } else {
                        SecureField("", text: $text)
                            .focused(focus, equals: field)
                            .onChange(of: text) { newValue, _ in
                                if newValue.count > 20 { text = String(newValue.prefix(20)) }
                            }
                    }
                }
                .frame(width: 260, height: 40)
                .textInputAutocapitalization(.never)
                
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .padding(.trailing, 1)
                        .foregroundStyle(.gray)
                })
            }
            .frame(width: 330, height: 50)
            .background(focus.wrappedValue == field ? Color("LoginBtnColor").opacity(0.06) : .clear)
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(focus.wrappedValue == field ? Color("LoginBtnColor") : Color("FontColor"),
                            lineWidth: focus.wrappedValue == field ? 1.2 : 0.6)
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

struct ValidatedInputField: View {
    let title: String
    @Binding var text: String
    let onCheckDuplicate: () async -> Void
    var focus: FocusState<SignUpFocusField?>.Binding
    let field: SignUpFocusField

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
                TextField("", text: $text)
                    .focused(focus, equals: field)
                    .frame(width: 210, height: 50)
                    .textInputAutocapitalization(.never)
                    .frame(width: 240, height: 50)
                    .background(focus.wrappedValue == field ? Color("LoginBtnColor").opacity(0.06) : .clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(focus.wrappedValue == field ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: focus.wrappedValue == field ? 1.2 : 0.6)
                            .animation(.easeInOut(duration: 0.15), value: focus.wrappedValue == field)
                    }

                Button("중복 확인") {
                    Task {
                        await onCheckDuplicate()
                    }
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(CHColors.Button.primary)
                .frame(width: 80, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(CHColors.Button.primary, lineWidth: 1)
                )
            }
        }
        .frame(width: 330, height: 90)
    }
}
