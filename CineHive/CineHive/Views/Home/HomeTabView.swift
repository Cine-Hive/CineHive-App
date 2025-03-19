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
    
    // 색상 테마
    private let backgroundColor = Color.black
    private let primaryColor = Color.red
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 검색 및 프로필 헤더
                searchAndProfileHeader()
                
                // 메인 콘텐츠
                ScrollView {
                    VStack(spacing: 0) {
                        // 커스텀 새로고침 인디케이터
                        CustomRefreshView(isRefreshing: isRefreshing)
                        
                        // 홈 콘텐츠
                        homeContent()
                        
                        // 푸터 공간
                        Color.clear.frame(height: 50)
                    }
                }
                .refreshable {
                    await refreshContent()
                }
            }
        }
        .foregroundColor(textColor)
        .navigationBarHidden(true)
        .overlay(
            isSearchActive ? searchOverlay() : nil
        )
        .sheet(isPresented: $showProfileOptions) {
            // ProfileOptionsView()
            Text("프로필 옵션")
                .presentationDetents([.medium])
        }
        .notification(
            isPresented: $showNotification,
            message: notificationMessage,
            icon: "bell.fill",
            accentColor: primaryColor
        )
        .onAppear {
            if viewModel.movies.isEmpty {
                Task {
                    await viewModel.fetchMovies()
                    await viewModel.fetchNowPlayingMovies()
                    await viewModel.fetchPopularMovies()
                    await viewModel.fetchTopRatedMovies()
                    await viewModel.fetchUpcomingMovies()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    notificationMessage = "CineHive에 오신 것을 환영합니다! 다양한 OTT 콘텐츠를 탐색해보세요."
                    withAnimation {
                        showNotification = true
                    }
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private func searchAndProfileHeader() -> some View {
        HStack(spacing: 15) {
            // 로고
            Text("CINEHIVE")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(textColor)
            
            Spacer()
            
            // 검색 버튼
            Button {
                withAnimation(.spring(response: 0.3)) {
                    isSearchActive = true
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(textColor)
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
                    .foregroundColor(textColor)
                    .font(.system(size: 18))
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    private func searchOverlay() -> some View {
        VStack(spacing: 0) {
            // 검색 헤더
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(secondaryColor)
                
                TextField("영화, TV 프로그램, 인물 검색", text: $searchText)
                    .foregroundColor(textColor)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(secondaryColor)
                    }
                }
                
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        isSearchActive = false
                        searchText = ""
                    }
                } label: {
                    Text("취소")
                        .foregroundColor(primaryColor)
                }
            }
            .padding()
            .background(Color(hex: "#1A1A1A"))
            
            // 검색 결과 또는 추천 검색어
            ScrollView {
                if searchText.isEmpty {
                    // 인기 검색어
                    VStack(alignment: .leading, spacing: 15) {
                        Text("인기 검색어")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ForEach(viewModel.popularMovies.prefix(10), id: \.id) { movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                HStack {
                                    Text("\(movie.id)")
                                        .font(.system(size: 14))
                                        .foregroundColor(movie.id <= 3 ? primaryColor : secondaryColor)
                                        .frame(width: 20)
                                    
                                    Text("인기 영화 \(movie.id)")
                                        .font(.system(size: 16))
                                        .foregroundColor(textColor)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            }
                        }
                    }
                } else {
                    // 검색 결과
                    Text("'\(searchText)'에 대한 검색 결과")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    if searchText.count > 1 {
                        // 여기서 실제 검색 결과를 표시할 수 있습니다.
                        // 서버의 검색 API를 호출하여 결과를 가져올 수 있습니다.
                        Text("검색 중...")
                            .foregroundColor(secondaryColor)
                            .padding()
                    } else {
                        Text("검색어를 더 입력해주세요")
                            .foregroundColor(secondaryColor)
                            .padding()
                    }
                }
            }
            .background(backgroundColor)
        }
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
    
    // MARK: - Tab Contents
    
    private func homeContent() -> some View {
        VStack(spacing: 30) {
            // 메인 배너 (현재 상영작)
            if !viewModel.nowPlayingMovies.isEmpty {
                BannerView(item: BannerItem(
                    imageURL: viewModel.nowPlayingMovies.first?.backDropURL,
                    title: "현재 상영작",
                    subtitle: "새로운 영화를 만나보세요"
                ))
                .frame(height: 250)
            }
            
            // 현재 상영 영화
            if !viewModel.nowPlayingMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "현재 상영 영화", actionTitle: "더보기")
                    
                    MovieListView(
                        movies: viewModel.nowPlayingMovies,
                        movieType: .nowPlaying,
                        viewModel: viewModel
                    )
                }
            }
            
            // 인기 영화
            if !viewModel.popularMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "인기 영화", actionTitle: "더보기")
                    
                    MovieListView(
                        movies: viewModel.popularMovies,
                        movieType: .popular,
                        viewModel: viewModel
                    )
                }
            }
            
            // 평점 높은 영화
            if !viewModel.topRatedMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "평점 높은 영화", actionTitle: "더보기")
                    
                    MovieListView(
                        movies: viewModel.topRatedMovies,
                        movieType: .topRated,
                        viewModel: viewModel
                    )
                }
            }
            
            // 개봉 예정작
            if !viewModel.upcomingMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "개봉 예정작", actionTitle: "더보기")
                    
                    MovieListView(
                        movies: viewModel.upcomingMovies,
                        movieType: .upcoming,
                        viewModel: viewModel
                    )
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
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
        notificationMessage = "영화 정보가 최신으로 업데이트되었습니다"
        
        isRefreshing = false
        
        // Show notification after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                showNotification = true
            }
        }
    }
}

#Preview {
    HomeTabView()
}
