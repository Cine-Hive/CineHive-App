//
//  SignUpView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Create Account")
                .frame(width: 320, height: 70)
                .font(.system(size: 22, weight: .bold))
            
            InputFieldView(title: "이메일", text: $viewModel.email)
            // 오류 메시지
            if let emailError = viewModel.emailErrorMessage {
                Text(emailError)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .frame(width: 320, height: 20, alignment: .leading)
            }
            
            // 이메일 중복 검사 결과 표시 (형식 오류가 없을 때만 표시)
            else if let emailCheck = viewModel.emailCheckMessage {
                Text(emailCheck)
                    .font(.system(size: 14))
                    .foregroundColor(emailCheck == "사용 가능한 이메일입니다." ? .green : .red)
                    .frame(width: 330, alignment: .leading)
            }
                
            PasswordFieldView(title: "비밀번호", text: $viewModel.password, showPassword: $viewModel.showPassword)
            InputFieldView(title: "닉네임", text: $viewModel.nickname)
            // 닉네임 중복 검사 결과 메시지 표시
            if let nicknameError = viewModel.nicknameErrorMessage {
                Text(nicknameError)
                    .font(.system(size: 14))
                    .foregroundColor(nicknameError == "사용 가능한 닉네임입니다." ? .green : .red)
                    .frame(width: 330, alignment: .leading)
                    .padding(.top, 1)
            }
            InputFieldView(title: "이름", text: $viewModel.name, isRequired: false)
            
            GenderSelectedView(selectedGender: $viewModel.selectedGender)
            
            Button(action: {
            // 로그인 화면으로 전환하는 코드 필요
            }, label: {
                Text("회원가입")
                    .frame(width: 330, height: 50)
                    .background(viewModel.isValid() ? Color("LoginBtnColor"): Color.gray).clipShape(RoundedRectangle(cornerRadius: 12))
            })
            .frame(height: 90)
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(.white)
            .disabled(!viewModel.isValid())
            Spacer()
        }
    }
}

#Preview {
    SignUpView()
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
