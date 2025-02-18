//
//  LoginView.swift
//  CineHive
//
//  Created by 존진 on 2/17/25.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State private var showPassword: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("LOGIN")
                    .font(.system(size: 25, weight: .bold))
                VStack {
                    Button(action: {
                        print("kakao")
                    }, label: {
                        HStack {
                            Image("KakaoLogo")
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("Kakao로 계속하기")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.black)
                        }
                        .frame(width: 330, height: 44)
                        .background(Color("KakaoColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    })
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            HStack {
                                Image("GoogleLogo")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .offset(x: 3)
                                Text("Google로 계속하기")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 330, height: 44)
                            .background(Color("GoogleColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        })
                    }
                    HStack {
                        Button(action: {}, label: {
                            HStack {
                                Image("NaverLogo")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                Text("Naver로 계속하기")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 330, height: 44)
                            .background(Color("NaverColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        })
                    }
                }
                .frame(width: 330, height: 250)
                
                Text("or use your account")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 320, height: 30, alignment: .leading)
                
                Section {
                    TextField("Email", text: $email)
                        .frame(width: 300, height: 50)
                        .textInputAutocapitalization(.never)    // 첫 글자 대문자 표출 X
                    HStack {
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button(action: {
                            self.showPassword.toggle()
                        }, label: {
                            Image(systemName: showPassword ? "eye" : "eye.slash")
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
                Button(action: {
                    
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
                    
                    // View 변경 해야함
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
