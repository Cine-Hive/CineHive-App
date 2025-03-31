//
//  ContentView.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var userState = UserState.shared
    @State private var networkMonitor = NetworkMonitor.shared
    @State private var showNetworkToast = false
    
    // 라우팅 상태 관리
    @State private var router = AppRouter()
    
    var body: some View {
        ZStack {
            switch router.currentFlow {
            case .auth:
                AuthView(router: router)
                    .transition(.opacity)
            case .login:
                LoginView(router: router)
                    .transition(.move(edge: .bottom))
            case .signUp:
                SignUpView(router: router)
                    .transition(.move(edge: .bottom))
            case .main:
                MainTabView()
                    .transition(.move(edge: .trailing))
            case .onboarding:
                //온보딩 준비중
                Text("온보딩 준비중")
            case .passwordReset:
                <#code#>
            }
        }
        .animation(.easeInOut, value: router.currentFlow)
        .onAppear {
            // 자동 로그인 or 게스트 로그인 시 바로 main으로
            if userState.isLoggedIn || userState.isGuestMode {
                router.goToMain()
            } else {
                router.goToAuth()
            }
        }
        .onChange(of: networkMonitor.isConnected) { _, isConnected in
            if !isConnected {
                showNetworkToast = true
            }
        }
        .toast(
            message: "인터넷 연결이 끊겼습니다",
            isPresented: $showNetworkToast,
            toastType: .error,
            actionTitle: "재시도",
            action: {
                Task {
                    let success = await networkMonitor.testConnection()
                    if success {
                        showNetworkToast = false
                    }
                }
            }
        )
    }
}


#Preview {
    ContentView()
}
