//
//  HomeTabView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HomeTabView: View {
    // 환경과 뷰모델
    @Environment(UserState.self) private var userState
    @State private var viewModel = HomeViewModel()
    @State private var profileModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 검색 및 프로필 헤더
                HomeHeaderView(
                    isSearchActive: $viewModel.isSearchActive,
                    showProfileOptions: $viewModel.showProfileOptions,
                    onProfileTap: profileModel.handleProfileTap,
                    avatarURL: profileModel.profileImageURLString
                )
                
                // 메인 콘텐츠
                ScrollView {
                    VStack(spacing: 0) {
                        // 커스텀 새로고침 인디케이터
                        CustomRefreshView(isRefreshing: viewModel.isRefreshing)
                        
                        // 메인 배너 (오늘의 추천)
                        HomeBannerView(banners: BannerItem.dummyBanners)
                        
                        // 인기 영화 섹션
                        PopularMoviesView()
                        
                        // 최고 평점 영화 섹션
                        TopRatedMoviesView()
                        
                        // 장르별 탐색 섹션
                        GenreBrowserView()
                        
                        // 현재 상영 영화
                        NowPlayingMoviesView()
                        
                        // 커뮤니티 하이라이트 섹션
                        CommunityHighlightsView()
                        
                        // 개봉 예정작
                        UpcomingMoviesView()
                        
                        // 푸터 공간
                        Color.clear.frame(height: 50)
                    }
                }
                .refreshable {
                    await viewModel.refreshContent()
                }
            }
            .errorToast(message: viewModel.error, isPresented: $viewModel.showErrorToast)
        }
        .foregroundColor(CHColors.textColor)
        .navigationBarHidden(true)
        .overlay {
            if viewModel.isSearchActive {
                SearchView(
                    searchText: $viewModel.searchText,
                    isSearchActive: $viewModel.isSearchActive
                )
            }
        }
        .onChange(of: viewModel.error) { _, _ in
            viewModel.handleErrorChange()
        }
        .sheet(isPresented: $viewModel.showProfileOptions) {
            ProfileOptionsSheet(
                isPresented: $viewModel.showProfileOptions,
                onLogout: viewModel.handleLogout,
                onSettingsTap: viewModel.handleSettingsTap,
                onActivityTap: viewModel.handleActivityTap,
                onFavoritesTap: viewModel.handleFavoritesTap
            )
        }
        .notification(
            isPresented: .init(
                get: { viewModel.showNotification },
                set: { isPresented in
                    if !isPresented {
                        viewModel.dismissNotification()
                    }
                }
            ),
            message: viewModel.notificationMessage,
            icon: "bell.fill"
        )
        .onAppear {
            Task {
                await viewModel.loadInitialData()
            }
        }
    }
}

// 미리보기
#Preview {
    HomeTabView()
        .environment(UserState.shared)
}
