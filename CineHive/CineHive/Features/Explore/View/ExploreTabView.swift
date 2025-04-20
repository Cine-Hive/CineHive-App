//
//  ExploreTabView.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct ExploreTabView: View {
    @State private var movieViewModel = MovieViewModel()
    @State private var dramaViewModel = DramaViewModel()
    @State private var contentType: ContentType = .movie
    @State private var selectedGenre: String? = "전체"
    @State private var isRefreshing = false
    @State private var searchText = ""
    @State private var isSearchActive = false
    
    // 콘텐츠 타입
    enum ContentType: String, CaseIterable {
        case movie = "영화"
        case drama = "드라마"
        case animation = "애니메이션"
    }
    
    // 장르 목록
    private var genres: [String] {
        let allGenres = ["전체"]
        
        switch contentType {
        case .movie:
            return allGenres + ["액션", "드라마", "SF", "코미디", "로맨스", "스릴러", "공포"]
        case .drama:
            return allGenres + ["로맨스", "코미디", "범죄", "판타지", "의학", "법정"]
        case .animation:
            return allGenres + ["가족", "액션", "판타지", "SF", "모험", "일본"]
        }
    }
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 검색 및 프로필 헤더
                searchHeader()
                
                // 콘텐츠 타입 선택기
                contentTypeSelector()
                
                // 장르 필터링
                genreFilterSection()
                
                // 메인 콘텐츠
                ScrollView {
                    VStack(spacing: 20) {
                        // 새로고침 인디케이터
                        CustomRefreshView(isRefreshing: isRefreshing)
                        
                        // 선택된 콘텐츠 타입에 따른 콘텐츠 표시
                        switch contentType {
                        case .movie:
                            movieContent()
                        case .drama:
                            dramaContent()
                        case .animation:
                            animationContent()
                        }
                        
                        // 푸터 공간
                        Color.clear.frame(height: 50)
                    }
                    .padding(.top, 10)
                }
                .refreshable {
                    await refreshContent()
                }
            }
        }
        .foregroundColor(CHColors.textColor)
        .navigationBarHidden(true)
        .overlay(
            isSearchActive ? searchOverlay() : nil
        )
        .onAppear {
            if movieViewModel.movies.isEmpty {
                Task {
                    await movieViewModel.fetchMovies()
                    await movieViewModel.fetchPopularMovies()
                    await movieViewModel.fetchTopRatedMovies()
                    await movieViewModel.fetchUpcomingMovies()
                }
            }
            
            if dramaViewModel.dramas.isEmpty {
                Task {
                    await dramaViewModel.fetchDramas()
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private func searchHeader() -> some View {
        HStack(spacing: 15) {
            // 제목
            Text("탐색")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(CHColors.textColor)
            
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
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    private func contentTypeSelector() -> some View {
        HStack(spacing: 0) {
            ForEach(ContentType.allCases, id: \.self) { type in
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        contentType = type
                        selectedGenre = "전체" // 콘텐츠 타입 변경 시 장르 초기화
                    }
                } label: {
                    Text(type.rawValue)
                        .font(.system(size: 16, weight: contentType == type ? .bold : .regular))
                        .foregroundColor(contentType == type ? CHColors.textColor : CHColors.secondaryColor)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
            }
        }
        // 선택 인디케이터
        .overlay(alignment: .bottom) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 2)
                
                Rectangle()
                    .fill(CHColors.primaryColor)
                    .frame(width: UIScreen.main.bounds.width / CGFloat(ContentType.allCases.count), height: 2)
                    .offset(x: CGFloat(ContentType.allCases.firstIndex(of: contentType) ?? 0) * UIScreen.main.bounds.width / CGFloat(ContentType.allCases.count))
                    .animation(.spring(response: 0.3), value: contentType)
            }
        }
    }
    
    private func genreFilterSection() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(genres, id: \.self) { genre in
                    Button {
                        withAnimation {
                            selectedGenre = genre
                        }
                    } label: {
                        Text(genre)
                            .font(.system(size: 14))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedGenre == genre ? CHColors.primaryColor : Color.gray.opacity(0.2))
                            .foregroundColor(selectedGenre == genre ? .white : .gray)
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
    
    private func searchOverlay() -> some View {
        VStack(spacing: 0) {
            // 검색 헤더
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(CHColors.secondaryColor)
                
                TextField("\(contentType.rawValue) 검색", text: $searchText)
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
            
            // 검색 결과
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
                                
                                Text("인기 \(contentType.rawValue) \(index)")
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
                        // 검색 결과 표시
                        if contentType == .movie {
                            ForEach(movieViewModel.searchResults, id: \.id) { movie in
                                NavigationLink(destination: DetailView(movieId: movie.id)) {
                                    searchResultRow(id: movie.id, posterURL: movie.posterURL)
                                }
                            }
                        } else {
                            // 드라마/애니메이션은 준비 중 메시지
                            Text("현재 \(contentType.rawValue) 검색 기능을 준비 중입니다")
                                .foregroundColor(CHColors.secondaryColor)
                                .padding()
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
        .onAppear {
            if searchText.count > 1 {
                Task {
                    await movieViewModel.searchMovies(query: searchText)
                }
            }
        }
        .onChange(of: searchText) { newValue in
            if newValue.count > 1 {
                Task {
                    await movieViewModel.searchMovies(query: newValue)
                }
            }
        }
    }
    
    private func searchResultRow(id: Int, posterURL: URL?) -> some View {
        HStack {
            // 포스터
            PosterView(posterURL: posterURL, width: 60, height: 90)
                .cornerRadius(6)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(contentType.rawValue) \(id)")
                    .font(.headline)
                    .foregroundColor(CHColors.textColor)
                
                Text(genres.dropFirst().prefix(2).joined(separator: " • "))
                    .font(.subheadline)
                    .foregroundColor(CHColors.secondaryColor)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    //MARK: - 콘텐츠 별로 화면
    private func movieContent() -> some View {
        VStack(spacing: 25) {
            // 인기 영화
            if !movieViewModel.popularMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "인기 영화", actionTitle: "더보기")
                    
                    MoviesView(
                        movies: movieViewModel.popularMovies,
                        movieType: .popular,
                        viewModel: movieViewModel
                    )
                }
            }
            
            // 평점 높은 영화
            if !movieViewModel.topRatedMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "평점 높은 영화", actionTitle: "더보기")
                    
                    MoviesView(
                        movies: movieViewModel.topRatedMovies,
                        movieType: .topRated,
                        viewModel: movieViewModel
                    )
                }
            }
            
            // 개봉 예정작
            if !movieViewModel.upcomingMovies.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "개봉 예정작", actionTitle: "더보기")
                    
                    MoviesView(
                        movies: movieViewModel.upcomingMovies,
                        movieType: .upcoming,
                        viewModel: movieViewModel
                    )
                }
            }
        }
    }
    
    private func dramaContent() -> some View {
//        VStack(spacing: 25) {
//            if !dramaViewModel.dramas.isEmpty {
//                VStack(alignment: .leading, spacing: 12) {
//                    SectionHeader(title: "드라마", actionTitle: "더보기")
//                    
//                    DramaListView(
//                        dramas: dramaViewModel.dramas,
//                        dramaType: .drama,
//                        viewModel: dramaViewModel
//                    )
//                }
//            }
//        }
        PreparingView(type: "드라마", actionTitle: "영화 콘텐츠 보러가기") {
            contentType = .movie
        }
    }
    
    private func animationContent() -> some View {
        PreparingView(type: "애니메이션", actionTitle: "영화 콘텐츠 보러가기") {
            contentType = .movie
        }
    }
    
    private func refreshContent() async {
        isRefreshing = true
        
        switch contentType {
        case .movie:
            await movieViewModel.fetchMovies()
            await movieViewModel.fetchPopularMovies()
            await movieViewModel.fetchTopRatedMovies()
            await movieViewModel.fetchUpcomingMovies()
        case .drama:
            await dramaViewModel.fetchDramas()
        case .animation:
            // 애니메이션은 아직 API 연동 없음
            break
        }
        
        isRefreshing = false
    }
}

#Preview {
    ExploreTabView()
}
