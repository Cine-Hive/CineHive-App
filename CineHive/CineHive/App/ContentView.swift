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
    
    var body: some View {
        Group {
            if userState.isLoggedIn || userState.isGuestMode {
                MainTabView()
            } else {
                AuthView()
            }
        }
        .onChange(of: networkMonitor.isConnected) { _, isConnected in
            // 네트워크 연결이 끊겼을 때 토스트 표시
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
                // 네트워크 재연결 시도
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
