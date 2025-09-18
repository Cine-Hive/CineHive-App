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
}

enum SignUpStep: Int, CaseIterable { case email, password, confirmPassword, nickname }

struct SignUpView: View {
    @State private var viewModel = SignUpViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: SignUpFocusField?
    @State private var step: SignUpStep = .email
    
    // 회원가입 완료 시 상위 화면으로 성공 콜백 전달
    var onSignUpSuccess: (() -> Void)? = nil
    
    var body: some View {
            VStack {
                VStack(spacing: 0) {
                    ZStack {
                        Text("회원가입")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .center)

                        HStack {
                            Button(action: {
                                switch step {
                                case .email:
                                    dismiss()
                                case .password:
                                    step = .email
                                case .confirmPassword:
                                    step = .password
                                case .nickname:
                                    step = .confirmPassword
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(Color("FontColor"))
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)

                    Divider().frame(height: 1)
                }
                // 현재 스텝에 따라 하나의 입력 화면만 표시
                switch step {
                case .email:
                    ValidatedInputField(
                        title: "이메일을 입력해 주세요.",
                        text: $viewModel.email,
                        onCheckDuplicate: { await viewModel.checkEmailWithFormatValidation() },
                        focus: $focusedField,
                        field: .email,
                    )
                case .password:
                    PasswordFieldView(title: "비밀번호를 입력해 주세요.", text: $viewModel.password, showPassword: $viewModel.showPassword, focus: $focusedField, field: .password)
                    if focusedField != .password, let errorMessage = viewModel.passwordErrorMessage {
                        Text(errorMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 10)
                    }
                case .confirmPassword:
                    PasswordFieldView(title: "비밀번호를 한 번 더 입력해 주세요.", text: $viewModel.confirmPassword, showPassword: $viewModel.showPassword, focus: $focusedField, field: .confirmPassword)
                    if focusedField != .confirmPassword, !viewModel.confirmPassword.isEmpty && viewModel.password != viewModel.confirmPassword {
                        Text("비밀번호가 일치하지 않습니다.")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .frame(width: 325, alignment: .leading)
                    }
                case .nickname:
                    ValidatedInputField(
                        title: "닉네임을 입력해 주세요.",
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
                }
                Spacer()
                // 다음/회원가입 버튼
                Button(action: {
                    Task {
                        switch step {
                        case .email:
                            step = .password
                        case .password:
                            step = .confirmPassword
                        case .confirmPassword:
                            step = .nickname
                        case .nickname:
                            await viewModel.signUp()
                        }
                    }
                }, label: {
                    Text(step == .nickname ? "회원가입" : "다음")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 48)
                })
                .foregroundStyle(.white)
                .background(viewModel.isNextEnabled(step: step) ? Color("LoginBtnColor") : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(!viewModel.isNextEnabled(step: step))
                .padding(.horizontal, 16)
                .padding(.bottom, 5)
            }
            .onAppear { focusedField = .email }
            .onChange(of: step) { newStep, _ in
                switch newStep {
                case .email: focusedField = .email
                case .password: focusedField = .password
                case .confirmPassword: focusedField = .confirmPassword
                case .nickname: focusedField = .nickname
                }
            }
            // 회원가입 성공 시 SignUpCompleteView로 이동
            .sheet(isPresented: $viewModel.isSignUpSuccess) {
                // onSignUpSuccess를 전달하여 SignUpCompleteView가 완료 시 이를 호출하도록 함
                SignUpCompleteView(nickname: viewModel.nickname, onComplete: {
                    dismiss()
                    onSignUpSuccess?()
                })
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


#Preview {
    NavigationStack {
        SignUpView(onSignUpSuccess: nil)
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
                Text(title)
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 30)
                    .padding(.top, 20)
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
                .padding(.leading, 13)
                .textInputAutocapitalization(.never)
                
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .padding(.trailing, 10)
                        .foregroundStyle(.gray)
                })
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(focus.wrappedValue == field ? Color("LoginBtnColor") : Color("FontColor"),
                            lineWidth: focus.wrappedValue == field ? 1.2 : 0.6)
                    .animation(.easeInOut(duration: 0.1), value: focus.wrappedValue == field)
            }
        }
        .frame(height: 90)
        .padding(.horizontal, 16)
    }
}

struct ValidatedInputField: View {
    let title: String
    @Binding var text: String
    let onCheckDuplicate: () async -> Void
    var focus: FocusState<SignUpFocusField?>.Binding
    let field: SignUpFocusField
    
    var body: some View {
        let maxLength: Int = {
            switch field {
            case .email:
                return 50
            case .nickname:
                return 12
            default:
                return 30
            }
        }()
        VStack {
            Text(title)
                .font(.system(size: 20, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 30)
                .padding(.top, 20)
            HStack {
                TextField(title, text: $text, prompt: Text(field == .email ? "1 ~ 50자 이내로 입력해 주세요.": field == .nickname ? "1 ~ 12자 이내로 입력해 주세요." : ""))
                    .focused(focus, equals: field)
                    .padding(.leading, 13)
                    .onChange(of: text) { newValue, _ in
                        if newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        }
                    }
                    .frame(height: 50)
                    .textInputAutocapitalization(.never)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(focus.wrappedValue == field ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: focus.wrappedValue == field ? 1.2 : 0.6)
                            .animation(.easeInOut(duration: 0.1), value: focus.wrappedValue == field)
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .padding(.horizontal, 16)
    }
}
