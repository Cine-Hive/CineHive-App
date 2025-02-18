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
            NavigationStack {
                //MovieListView
                
            }
            .tabItem {
                Label("홈", systemImage: "house")
            }
            .refreshable { }
            
            NavigationStack {
                Text("검색 뷰")
            }
            .tabItem {
                Label("검색", systemImage: "magnifyingglass")
            }
            .refreshable { }
            
            NavigationStack {
                Text("게시판 뷰")
            }
            .tabItem {
                Label("게시판", systemImage: "quote.bubble")
            }
            .refreshable { }
            
            NavigationStack {
                Text("프로필 뷰")
            }
            .tabItem {
                Label("프로필", systemImage: "person")
            }
            .refreshable { }
        }
    }
}

#Preview {
    MainTabView()
}
