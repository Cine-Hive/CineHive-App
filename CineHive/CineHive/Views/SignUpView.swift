//
//  SignUpView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var nickname: String = ""
    @State private var name: String = ""
    @State private var gender: String = ""
    @State private var selectedMan: Bool = false
    @State private var selectedWoman: Bool = false
    @State private var showPassword: Bool = false

    
    var body: some View {
        VStack {
            Spacer()
            Text("Create Account")
                .frame(width: 320, height: 70)
                .font(.system(size: 22, weight: .bold))
            
            InputFieldView(title: "이메일", text: $email)
            PasswordFieldView(title: "비밀번호", text: $password, showPassword: $showPassword)
            InputFieldView(title: "닉네임", text: $nickname)
            InputFieldView(title: "이름", text: $name)
            
            VStack {
                Text("성별")
                    .frame(width: 320, height: 25, alignment: .leading)
                    .font(.system(size: 17))
                
                HStack {
                    Button(action: {
                        selectedMan.toggle()
                    }, label: {
                        Text("남자")
                            .foregroundColor(selectedMan ? Color("LoginBtnColor") : Color("FontColor"))
                            .frame(width: 160, height: 50)
                    })
                    .overlay() {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedMan ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: 0.6)
                    }
                    
                    Button(action: {
                        selectedWoman.toggle()
                    }, label: {
                        Text("여자")
                            .foregroundColor(selectedWoman ? Color("LoginBtnColor") : Color("FontColor"))
                            .frame(width: 160, height: 50)
                    })
                    .overlay() {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedWoman ? Color("LoginBtnColor") : Color("FontColor"), lineWidth: 0.6)
                    }
                }
                .frame(width: 330, height: 50)
   
            }
            .frame(width: 330, height: 90)
            
            Button(action: {
                print("gd")
            }, label: {
                Text("회원가입")
                    .frame(width: 330, height: 50)
                    .background(Color("LoginBtnColor")).clipShape(RoundedRectangle(cornerRadius: 12))
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
            
            TextField("Email", text: $text)
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
                        TextField("Password", text: $text)
                    } else {
                        SecureField("Password", text: $text)
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
