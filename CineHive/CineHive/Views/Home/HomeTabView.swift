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
    @State private var selectedOTT: OTTService = .netflix
    
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
                        if !viewModel.nowPlayingMovies.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionHeader(title: "현재 상영 영화", actionTitle: "더보기")
                                
                                MovieListView(
                                    movies: viewModel.nowPlayingMovies,
                                    movieType: .nowPlaying,
                                    viewModel: viewModel
                                )
                            }
                            .padding(.top, 30)
                        }
                        
                        // 커뮤니티 하이라이트 섹션
                        CommunityHighlightsView()
                        
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
                            .padding(.top, 30)
                        }
                        
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
        }
        .foregroundColor(CHColors.textColor)
        .navigationBarHidden(true)
        .overlay(
            isSearchActive ? SearchOverlayView(
                searchText: $searchText,
                isSearchActive: $isSearchActive
            ) : nil
        )
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
                        notificationMessage = "CineHive에 오신 것을 환영합니다! 다양한 OTT 콘텐츠를 탐색해보세요."
                        withAnimation {
                            showNotification = true
                        }
                    }
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

// 검색 오버레이 컴포넌트
struct SearchOverlayView: View {
    @Binding var searchText: String
    @Binding var isSearchActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // 검색 헤더
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(CHColors.secondaryColor)
                
                TextField("영화, TV 프로그램, 인물 검색", text: $searchText)
                    .foregroundColor(CHColors.textColor)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(CHColors.secondaryColor)
                    }
                }
                
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        isSearchActive = false
                        searchText = ""
                    }
                } label: {
                    Text("취소")
                        .foregroundColor(CHColors.primaryColor)
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
                        
                        ForEach(1...10, id: \.self) { index in
                            HStack {
                                Text("\(index)")
                                    .font(.system(size: 14))
                                    .foregroundColor(index <= 3 ? CHColors.primaryColor : CHColors.secondaryColor)
                                    .frame(width: 20)
                                
                                Text("인기 검색어 \(index)")
                                    .font(.system(size: 16))
                                    .foregroundColor(CHColors.textColor)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                } else {
                    // 검색 결과
                    Text("'\(searchText)'에 대한 검색 결과")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    if searchText.count > 1 {
                        ForEach(1...5, id: \.self) { _ in
                            SearchResultRow()
                        }
                    } else {
                        Text("검색어를 더 입력해주세요")
                            .foregroundColor(CHColors.secondaryColor)
                            .padding()
                    }
                }
            }
            .background(CHColors.backgroundColor)
        }
        .background(CHColors.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

// 검색 결과 행 컴포넌트
struct SearchResultRow: View {
    var body: some View {
        HStack(spacing: 15) {
            // 포스터
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 45, height: 68)
            
            // 정보
            VStack(alignment: .leading, spacing: 4) {
                Text("검색 결과 제목")
                    .font(.system(size: 16))
                    .foregroundColor(CHColors.textColor)
                
                HStack {
                    Text("2023")
                    Text("•")
                    Text("영화")
                    Text("•")
                    Text("액션")
                }
                .font(.caption)
                .foregroundColor(CHColors.secondaryColor)
                
                // OTT 플랫폼
                HStack {
                    Image(systemName: "n.square.fill")
                        .foregroundColor(CHColors.OTT.netflix)
                    
                    Image(systemName: "d.square.fill")
                        .foregroundColor(CHColors.OTT.disney)
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 10))
                    
                    Text("8.7")
                        .font(.system(size: 12))
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
    }
}





// OTT별 인기 콘텐츠 섹션 컴포넌트
struct OTTPopularContentsView: View {
    let movies: [Movie]
    @Binding var selectedOTT: OTTService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "OTT별 인기 콘텐츠", actionTitle: "더보기")
            
            // OTT 선택 버튼
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(OTTService.allCases, id: \.self) { ott in
                        ottPlatformButton(ott: ott, isSelected: selectedOTT == ott)
                            .onTapGesture {
                                withAnimation(.spring(duration: 0.3)) {
                                    selectedOTT = ott
                                }
                            }
                    }
                }
                .padding(.horizontal, 15)
            }
            
            // 선택된 OTT의 콘텐츠
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(movies.prefix(8), id: \.id) { movie in
                        NavigationLink(destination: DetailView(movieId: movie.id)) {
                            ottContentCard(movie: movie)
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 8)
            }
        }
        .padding(.top, 30)
    }
    
    // OTT 플랫폼 버튼
    private func ottPlatformButton(ott: OTTService, isSelected: Bool) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isSelected ? ott.color.opacity(0.3) : Color.gray.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: ott.iconName)
                    .foregroundColor(isSelected ? ott.color : CHColors.secondaryColor)
                    .font(.system(size: 24))
            }
            
            Text(ott.name)
                .font(.system(size: 12))
                .foregroundColor(isSelected ? CHColors.textColor : CHColors.secondaryColor)
        }
    }
    
    // OTT 콘텐츠 카드
    private func ottContentCard(movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // 포스터 이미지
            PosterView(posterURL: movie.posterURL, width: 120, height: 180)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.white.opacity(0.1), lineWidth: 0.5)
                )
            
            // 제목
            VStack(alignment: .leading, spacing: 4) {
                Text("영화 \(movie.id)")
                    .font(.system(size: 14))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(1)
                
                // 평점
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 12))
                    
                    Text(String(format: "%.1f", 8.0 + Double(movie.id % 20) / 10))
                        .font(.system(size: 12))
                        .foregroundColor(CHColors.secondaryColor)
                }
                
                // OTT 플랫폼 뱃지 (선택된 OTT)
                HStack(spacing: 2) {
                    Image(systemName: selectedOTT.iconName)
                        .foregroundColor(selectedOTT.color)
                        .font(.system(size: 10))
                    
                    Text("독점")
                        .font(.system(size: 9))
                        .foregroundColor(CHColors.textColor)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(selectedOTT.color.opacity(0.2))
                .cornerRadius(3)
            }
            .frame(width: 120)
        }
    }
}

#Preview {
    HomeTabView()
}
