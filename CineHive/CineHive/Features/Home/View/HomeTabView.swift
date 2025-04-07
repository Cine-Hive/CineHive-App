//
//  HomeView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HomeTabView: View {
    @State private var movieViewModel = MovieViewModel()
    @State private var popularMoviesViewModel = PopularMoviesViewModel()
    @State private var topRatedMoviesViewModel = TopRatedMoviesViewModel()
    @State private var nowPlayingMoviesViewModel = NowPlayingMoviesViewModel()
    //@State private var upcomingMoviesViewModel = UpcomingMoviesViewModel() // 필요하다면 추가
    @State private var showProfileOptions = false
    @State private var showNotification = false
    @State private var isRefreshing = false
    @State private var notificationMessage = "최신 OTT 정보가 업데이트 되었습니다"
    @State private var searchText = ""
    @State private var isSearchActive = false
    @State private var selectedOTT: OTT = .netflix
    @State private var showErrorToast = false
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 검색 및 프로필 헤더
                HomeHeaderView(
                    isSearchActive: $isSearchActive,
                    showProfileOptions: $showProfileOptions
                )
                
                // 메인 콘텐츠
                ScrollView {
                    VStack(spacing: 0) {
                        // 커스텀 새로고침 인디케이터
                        CustomRefreshView(isRefreshing: isRefreshing)
                        
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
                        
                        // OTT별 인기 콘텐츠 섹션
//                        OTTPopularContentsView(
//                            movies: viewModel.popularMovies,
//                            selectedOTT: $selectedOTT
//                        )
                        
                        // 푸터 공간
                        Color.clear.frame(height: 50)
                    }
                }
                .refreshable {
                    await refreshContent()
                }
            }
            .errorToast(message: movieViewModel.error, isPresented: $showErrorToast)
            
        }
        .foregroundColor(CHColors.textColor)
        .navigationBarHidden(true)
        .overlay(
            isSearchActive
            ? SearchView(
                searchText: $searchText,
                isSearchActive: $isSearchActive
            ) : nil
        )
        .onChange(of: movieViewModel.error) { _, newValue in
            if let newValue, !newValue.isEmpty {
                showErrorToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        showErrorToast = false
                        movieViewModel.clearError()
                    }
                }
            }
        }
        .sheet(isPresented: $showProfileOptions) {
            // ProfileOptionsView()
            Text("프로필 옵션")
                .presentationDetents([.medium])
        }
        .notification(
            isPresented: $showNotification,
            message: notificationMessage,
            icon: "bell.fill"
        )
        .onAppear {
            if movieViewModel.movies.isEmpty {
                Task {
                    await movieViewModel.fetchMovies()
                    await movieViewModel.fetchNowPlayingMovies()
                    await movieViewModel.fetchPopularMovies()
                    await movieViewModel.fetchTopRatedMovies()
                    await movieViewModel.fetchUpcomingMovies()
                    
                    // 환영 메시지 표시
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        notificationMessage =
                        "CineHive에 오신 것을 환영합니다! 다양한 OTT 콘텐츠를 탐색해보세요."
                        withAnimation {
                            showNotification = true
                        }
                    }
                }
            }
        }
    }
    
    private func refreshContent() async {
        isRefreshing = true
        
        Task {
            await movieViewModel.fetchMovies()
            await movieViewModel.fetchNowPlayingMovies()
            await movieViewModel.fetchPopularMovies()
            await movieViewModel.fetchTopRatedMovies()
            await movieViewModel.fetchUpcomingMovies()
        }
        
        // Show notification after refresh
        notificationMessage = "OTT 콘텐츠 정보가 최신으로 업데이트되었습니다"
        
        isRefreshing = false
        
        // Show notification after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                showNotification = true
            }
        }
    }
}

// 홈 화면 헤더 컴포넌트
struct HomeHeaderView: View {
    @Binding var isSearchActive: Bool
    @Binding var showProfileOptions: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            // 로고
            Text("CineHive")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(CHColors.primaryColor)
            
            Spacer()
            
            // 검색 버튼
            Button {
                withAnimation(.spring(response: 0.3)) {
                    isSearchActive = true
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(CHColors.textColor)
                    .font(.system(size: 18))
            }
            .buttonStyle(ScaleButtonStyle())
            
            // 프로필 버튼
            Button {
                withAnimation(.spring(response: 0.3)) {
                    showProfileOptions.toggle()
                }
                
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            } label: {
                Group {
                    if UserState.shared.isLoggedIn, let user = UserState.shared.currentUser {
                        // 사용자 이니셜 표시 (실제 프로필 이미지가 있으면 그것을 사용)
                        Text(String(user.nickname.prefix(1)))
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 22, height: 22)
                            .background(CHColors.primaryColor)
                            .clipShape(Circle())
                    } else if UserState.shared.isGuestMode {
                        // 게스트 모드 아이콘
                        HStack {
                            Text("게스트")
                                .font(.caption2)
                                .foregroundStyle(CHColors.gray)
                        }
                    } else {
                        // 기본 아이콘
                        Image(systemName: "person.circle")
                            .foregroundColor(CHColors.textColor)
                            .font(.system(size: 18))
                    }
                }
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

#Preview {
    HomeTabView()
}
