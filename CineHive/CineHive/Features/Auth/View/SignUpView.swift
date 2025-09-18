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

struct SignUpView: View {
    @State private var viewModel = SignUpViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: SignUpFocusField?
    // 멀티 스텝 진행 상태
    private enum Step: Int, CaseIterable { case email, password, confirmPassword, nickname }
    @State private var step: Step = .email
    
    // 회원가입 완료 시 상위 화면으로 성공 콜백 전달
    var onSignUpSuccess: (() -> Void)? = nil
    
    // 다음 버튼 활성화 상태
    private var nextEnabled: Bool { isNextEnabled() }
    
    // 다음 버튼 활성화 로직
    private func isNextEnabled() -> Bool {
        switch step {
        case .email:
            return !viewModel.email.isEmpty && viewModel.isValidEmail(viewModel.email)
        case .password:
            return !viewModel.password.isEmpty && viewModel.passwordErrorMessage == nil
        case .confirmPassword:
            return !viewModel.confirmPassword.isEmpty && viewModel.password == viewModel.confirmPassword
        case .nickname:
            return !viewModel.nickname.isEmpty
        }
    }
    
    var body: some View {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            switch step {
                            case .email:
                                dismiss() // 첫 단계에서는 실제 뒤로가기(닫기)
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
                                .frame(width: 24, height: 24)
                        }
                        Spacer()
                        Text("회원가입")
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        // 가운데 정렬 보정을 위한 우측 더미 공간 (좌측 버튼과 너비 맞춤)
                        Color.clear
                            .frame(width: 24, height: 24)
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
                    PasswordFieldView(title: "비밀번호", text: $viewModel.password, showPassword: $viewModel.showPassword, focus: $focusedField, field: .password)
                    if focusedField != .password, let errorMessage = viewModel.passwordErrorMessage {
                        Text(errorMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .frame(width: 325, alignment: .leading)
                    }
                case .confirmPassword:
                    PasswordFieldView(title: "비밀번호 확인", text: $viewModel.confirmPassword, showPassword: $viewModel.showPassword, focus: $focusedField, field: .confirmPassword)
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
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: 330, minHeight: 48)
                })
                .foregroundStyle(.white)
                .background(nextEnabled ? Color("LoginBtnColor") : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(!nextEnabled)
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
            HStack {
                Text(title)
                    .font(.system(size: 17))
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
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(focus.wrappedValue == field ? Color("LoginBtnColor") : Color("FontColor"),
                            lineWidth: focus.wrappedValue == field ? 1.2 : 0.6)
                    .animation(.easeInOut(duration: 0.1), value: focus.wrappedValue == field)
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
                .frame(width: 330, height: 30, alignment: .leading)
                .padding(.top, 20)
            
            HStack {
                TextField(title, text: $text, prompt: Text(field == .email ? "1 ~ 50자 이내로 입력해 주세요": field == .nickname ? "1 ~ 12자 이내로 입력해 주세요" : ""))
                    .focused(focus, equals: field)
                    .onChange(of: text) { newValue, _ in
                        if newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        }
                    }
                    .frame(width: 300, height: 50)
                    .textInputAutocapitalization(.never)
                    .frame(width: 330, height: 50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(focus.wrappedValue == field ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: focus.wrappedValue == field ? 1.2 : 0.6)
                            .animation(.easeInOut(duration: 0.1), value: focus.wrappedValue == field)
                    }
            }
        }
        .frame(width: 330, height: 90)
    }
}
