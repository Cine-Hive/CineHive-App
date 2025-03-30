//
//  MainTabView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var previousTab = 0
    @State private var tabBarManager = TabBarManager.shared

    @Bindable var networkMonitor = NetworkMonitor.shared
    @State private var showNetworkError = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                CHColors.backgroundColor.edgesIgnoringSafeArea(.all)

                ZStack {
                    switch selectedTab {
                    case 0:
                        HomeTabView()
                            .transition(.opacity)
                    case 1:
                        ExploreTabView()
                            .transition(.opacity)
                    case 2:
                        CommunityTabView()
                            .transition(.opacity)
                    case 3:
                        PreparingView(
                            type: "프로필",
                            actionTitle: "확인"
                        ) {
                            selectedTab = previousTab
                        }
                        .transition(.opacity)
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(.easeInOut(duration: 0.2), value: selectedTab)
                .background(CHColors.backgroundColor)

                CustomTabBar(selectedTab: $selectedTab, items: TabItem.items)
                    .offset(y: tabBarManager.isVisible ? 0 : 100)
                    .animation(.spring(response: 0.3), value: tabBarManager.isVisible)
                    .ignoresSafeArea(.all, edges: .bottom)
                    .padding(.bottom, -30)
            }
            .onChange(of: networkMonitor.isConnected) { _, isConnected in
                if !isConnected {
                    showNetworkError = true
                }
            }
            .errorToast(
                message: "인터넷 연결이 끊겼습니다",
                isPresented: $showNetworkError,
                accentColor: .red,
                iconName: "wifi.slash",
                actionTitle: "재시도",
                action: {
                    // 재시도 로직: 필요한 경우 네트워크 요청 트리거
                    print("재시도 버튼 눌림")
                }
            )
        }
    }
}

#Preview {
    MainTabView()
}

