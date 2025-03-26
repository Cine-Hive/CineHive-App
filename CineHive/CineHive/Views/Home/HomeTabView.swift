//
//  HomeView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HomeTabView: View {
    @State private var viewModel = MovieViewModel()
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
                        PopularMoviesView(movies: viewModel.popularMovies)

                        // 최고 평점 영화 섹션
                        TopRatedMoviesView(movies: viewModel.topRatedMovies)

                        // 장르별 탐색 섹션
                        GenreExploreView()

                        // 현재 상영 영화
                        nowPlayingSection()

                        // 커뮤니티 하이라이트 섹션
                        CommunityHighlightsView()

                        // 개봉 예정작
                        upcomingSection()

                        // OTT별 인기 콘텐츠 섹션
                        OTTPopularContentsView(
                            movies: viewModel.popularMovies,
                            selectedOTT: $selectedOTT
                        )

                        // 푸터 공간
                        Color.clear.frame(height: 50)
                    }
                }
                .refreshable {
                    await refreshContent()
                }
            }
            .errorToast(message: viewModel.error, isPresented: $showErrorToast)

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
        .onChange(of: viewModel.error) { _, newValue in
            if let newValue, !newValue.isEmpty {
                showErrorToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        showErrorToast = false
                        viewModel.clearError()
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
            if viewModel.movies.isEmpty {
                Task {
                    await viewModel.fetchMovies()
                    await viewModel.fetchNowPlayingMovies()
                    await viewModel.fetchPopularMovies()
                    await viewModel.fetchTopRatedMovies()
                    await viewModel.fetchUpcomingMovies()

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
            await viewModel.fetchMovies()
            await viewModel.fetchNowPlayingMovies()
            await viewModel.fetchPopularMovies()
            await viewModel.fetchTopRatedMovies()
            await viewModel.fetchUpcomingMovies()
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

    private func nowPlayingSection() -> some View {
        Group {
            if !viewModel.nowPlayingMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "현재 상영 영화", actionTitle: "더보기")

                    MovieListView(
                        movies: viewModel.nowPlayingMovies,
                        movieType: .nowPlaying,
                        viewModel: viewModel
                    )
                }
                .padding(.horizontal, 15)
                .padding(.top, 30)
            }
        }
    }

    private func upcomingSection() -> some View {
        Group {
            if !viewModel.upcomingMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "개봉 예정작", actionTitle: "더보기")

                    MovieListView(
                        movies: viewModel.upcomingMovies,
                        movieType: .upcoming,
                        viewModel: viewModel
                    )
                }
                .padding(.top, 30)
                .padding(.horizontal, 15)
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

                // Add haptic feedback
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            } label: {
                Image(systemName: "person.circle")
                    .foregroundColor(CHColors.textColor)
                    .font(.system(size: 18))
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
