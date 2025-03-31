//
//  SignUpCompleteView.swift
//  CineHive
//
//  Created by 이종민 on 3/31/25.
//

import SwiftUI

struct SignUpCompleteView: View {
    let nickname: String
    
    let onComplete: () -> Void
    
    // 애니메이션용 상태 변수
    @State private var showIcon = false
    @State private var showWelcome = false
    @State private var showMessage = false
    @State private var showButtons = false
    
    var body: some View {
        ZStack {
            // 배경 그라데이션
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.8), Color("LoginBtnColor").opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 28) {
                Spacer()
                
                // 성공 아이콘
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color("LoginBtnColor"))
                    .padding(.bottom, 8)
                    .shadow(color: Color("LoginBtnColor").opacity(0.5), radius: 10, x: 0, y: 0)
                    .scaleEffect(showIcon ? 1.0 : 0.5)
                    .opacity(showIcon ? 1.0 : 0.0)
                    .blur(radius: showIcon ? 0 : 10)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showIcon)
                
                // 환영 메시지
                Text("\(nickname)님, 환영합니다!")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                    .opacity(showWelcome ? 1.0 : 0.0)
                    .offset(y: showWelcome ? 0 : 20)
                    .animation(.easeInOut(duration: 0.5).delay(0.3), value: showWelcome)
                
                Text("회원가입이 성공적으로 완료되었습니다.")
                    .font(.system(size: 18))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                    .opacity(showMessage ? 1.0 : 0.0)
                    .offset(y: showMessage ? 0 : 20)
                    .animation(.easeInOut(duration: 0.5).delay(0.5), value: showMessage)
                
                // 추가 정보 안내
                VStack(spacing: 16) {
                    Text("영화 추천을 개선하기 위해\n추가 정보를 입력해보세요.")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    HStack(spacing: 16) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color("LoginBtnColor").opacity(0.5))
                                .frame(width: 10, height: 10)
                                .scaleEffect(showMessage ? 1.0 : 0.5)
                                .animation(.easeInOut(duration: 0.3).delay(0.6 + Double(index) * 0.1), value: showMessage)
                        }
                    }
                }
                .opacity(showMessage ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.5).delay(0.7), value: showMessage)
                
                Spacer()
                
                VStack(spacing: 16) {
                    // 계속하기 버튼 - NavigationLink 사용
                    NavigationLink {
                        PreparingView(
                            type: "추가 정보",
                            actionTitle: "로그인 화면으로 이동",
                            action: {
                                onComplete()
                            }
                        )
                    } label: {
                        Text("추가 정보 입력하기")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("LoginBtnColor"), Color("LoginBtnColor").opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: Color("LoginBtnColor").opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    
                    // 건너뛰기 버튼
                    Button {
                        // 로그인 화면으로 이동
                        onComplete()
                    } label: {
                        Text("나중에 하기")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
                .opacity(showButtons ? 1.0 : 0.0)
                .offset(y: showButtons ? 0 : 30)
                .animation(.easeInOut(duration: 0.5).delay(0.9), value: showButtons)
            }
        }
        .onAppear {
            // 순차적으로 애니메이션 시작
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                showIcon = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showWelcome = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showMessage = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            showButtons = true
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
