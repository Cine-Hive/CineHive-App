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
            PasswordFieldView(title: "비밀번호", text: $viewModel.password, showPassword: $viewModel.showPassword)
            InputFieldView(title: "닉네임", text: $viewModel.nickname)
            InputFieldView(title: "이름", text: $viewModel.name, isRequired: false)
            
            VStack {
                Text("성별")
                    .frame(width: 320, height: 25, alignment: .leading)
                    .font(.system(size: 17))
                
                HStack {
                    Button(action: {
                        viewModel.selectedMan.toggle()
                    }, label: {
                        Text("남자")
                            .foregroundColor(viewModel.selectedMan ? Color("LoginBtnColor") : Color("FontColor"))
                            .frame(width: 160, height: 50)
                    })
                    .overlay() {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(viewModel.selectedMan ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: 0.6)
                    }
                    
                    Button(action: {
                        viewModel.selectedWoman.toggle()
                    }, label: {
                        Text("여자")
                            .foregroundColor(viewModel.selectedWoman ? Color("LoginBtnColor") : Color("FontColor"))
                            .frame(width: 160, height: 50)
                    })
                    .overlay() {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(viewModel.selectedWoman ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: 0.6)
                    }
                }
                .frame(width: 330, height: 50)
   
            }
            .frame(width: 330, height: 90)
            
            Button(action: {
            }, label: {
                Text("회원가입")
                    .frame(width: 330, height: 50)
                    .background(viewModel.isValid() ? Color("LoginBtnColor"): Color.gray).clipShape(RoundedRectangle(cornerRadius: 12))
            })
            .frame(height: 90)
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(.white)
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
