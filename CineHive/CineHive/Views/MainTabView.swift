//
//  MainTabView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeTabView()
                }
                .tag(0)
                
                NavigationStack {
                    ExploreTabView()
                }
                .tag(1)
                
                NavigationStack {
                    CommunityTabView()
                }
                .tag(2)
                
                NavigationStack {
                    ProfileTabView()
                }
                .tag(3)
            }
            .background(CHColors.backgroundColor)
            
            // 커스텀 탭바를 오버레이로 표시
            CustomTabBar(selectedTab: $selectedTab, items: TabItem.items)
                .ignoresSafeArea(.all, edges: .bottom)
        }
        .background(CHColors.backgroundColor)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}
