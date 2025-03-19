//
//  MainTabView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // 홈 탭
            NavigationStack {
                HomeTabView()
            }
            .tabItem {
                Label("홈", systemImage: "house")
            }
            
            // 탐색 탭
            NavigationStack {
                ExploreTabView()
            }
            .tabItem {
                Label("탐색", systemImage: "magnifyingglass")
            }
            
            // 커뮤니티 탭 (게시판)
            NavigationStack {
                CommunityTabView()
            }
            .tabItem {
                Label("커뮤니티", systemImage: "bubble.left.and.bubble.right")
            }
            
            // 마이 탭 (프로필)
            NavigationStack {
                ProfileTabView()
            }
            .tabItem {
                Label("마이", systemImage: "person")
            }
        }
        .accentColor(CHColors.primaryColor)
    }
}

#Preview {
    MainTabView()
}
