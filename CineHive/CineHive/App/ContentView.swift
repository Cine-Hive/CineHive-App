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
    @State private var isShowingSplash = true
    
    var body: some View {
        ZStack {
            Group {
                if userState.isLoggedIn || userState.isGuestMode {
                    MainTabView()
                } else {
                    AuthView()
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
            
            // 스플래시 화면
            if isShowingSplash {
                SplashView()
                    .transition(.opacity)
                    .zIndex(1)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isShowingSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
