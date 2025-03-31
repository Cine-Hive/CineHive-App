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
        ZStack {
            RoutingView(root: .welcome)
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
