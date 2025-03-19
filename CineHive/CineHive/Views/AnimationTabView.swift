//
//  AnimationTabView.swift
//  CineHive
//
//  Created by 이종민 on 3/18/25.
//

import SwiftUI

struct AnimationTabView: View {
    @State private var viewModel = MovieViewModel()
    @State private var selectedGenre: String? = "전체"
    @State private var isRefreshing = false
    @State private var searchText = ""
    @State private var isSearchActive = false
    
    // 색상 테마
    private let backgroundColor = Color.black
    private let primaryColor = Color(hex: "#FF2F6E")
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    // 장르 목록
    private let genres = ["전체", "가족", "액션", "코미디", "판타지", "SF", "모험", "일본"]
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 검색 및 프로필 헤더
                searchHeader()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // 커스텀 새로고침 인디케이터
                        CustomRefreshView(isRefreshing: isRefreshing)
                        
                        // 준비 중 메시지
                        if viewModel.movies.isEmpty {
                            preparingContentMessage()
                        } else {
                            // 애니메이션 콘텐츠 (임시 데이터)
                            sampleAnimationContent()
                        }
                        
                        // 푸터 공간
                        Color.clear.frame(height: 50)
                    }
                    .padding(.top, 20)
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
        .onAppear {
            if viewModel.movies.isEmpty {
                Task {
                    await viewModel.fetchMovies()
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private func searchHeader() -> some View {
        HStack(spacing: 15) {
            // 제목
            Text("애니메이션")
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
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    private func preparingContentMessage() -> some View {
        VStack(spacing: 20) {
            Image(systemName: "popcorn.fill")
                .font(.system(size: 50))
                .foregroundColor(primaryColor)
                .padding()
            
            Text("애니메이션 준비중...")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
            
            Text("곧 다양한 애니메이션을 만나보실 수 있습니다!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .foregroundColor(secondaryColor)
            
            Button {
                Task {
                    isRefreshing = true
                    await viewModel.fetchMovies()
                    isRefreshing = false
                }
            } label: {
                Text("새로고침")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(primaryColor)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 100)
    }
    
    private func sampleAnimationContent() -> some View {
        VStack(spacing: 30) {
            // 장르 필터
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
                                .background(selectedGenre == genre ? primaryColor : Color.gray.opacity(0.2))
                                .foregroundColor(selectedGenre == genre ? .white : .gray)
                                .cornerRadius(16)
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            
            // 인기 애니메이션 (영화 데이터를 임시로 사용)
            VStack(alignment: .leading, spacing: 12) {
                SectionHeader(title: "인기 애니메이션", actionTitle: "더보기")
                
                // 임시로 영화 데이터 활용
                MovieListView(
                    movies: viewModel.movies.prefix(10).map { $0 },
                    movieType: .movies,
                    viewModel: viewModel
                )
            }
            
            // 신규 애니메이션
            VStack(alignment: .leading, spacing: 12) {
                SectionHeader(title: "신규 애니메이션", actionTitle: "더보기")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(1...5, id: \.self) { index in
                            newAnimationCard(index: index)
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
            
            // 일본 애니메이션
            VStack(alignment: .leading, spacing: 12) {
                SectionHeader(title: "일본 애니메이션", actionTitle: "더보기")
                
                // 임시로 영화 데이터 활용
                MovieListView(
                    movies: viewModel.movies.suffix(10).map { $0 },
                    movieType: .movies,
                    viewModel: viewModel
                )
            }
        }
    }
    
    private func newAnimationCard(index: Int) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // 애니메이션 썸네일
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 120)
                    .cornerRadius(8)
                    .overlay(
                        Image(systemName: "sparkles")
                            .font(.system(size: 30))
                            .foregroundColor(.white.opacity(0.7))
                    )
                
                // NEW 배지
                Text("NEW")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(primaryColor)
                    .cornerRadius(4)
                    .padding(8)
            }
            
            // 애니메이션 제목
            Text("애니메이션 시리즈 \(index)")
                .font(.headline)
                .foregroundColor(textColor)
            
            // 정보
            Text("\(2023) • 에피소드 \(index * 4)")
                .font(.caption)
                .foregroundColor(secondaryColor)
                .lineLimit(1)
            
            // 평점
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 10))
                
                Text(String(format: "%.1f", 7.5 + Double(index) / 10))
                    .font(.caption)
                    .foregroundColor(textColor)
            }
        }
        .frame(width: 200)
        .padding(.vertical, 5)
    }
    
    private func searchOverlay() -> some View {
        VStack(spacing: 0) {
            // 검색 헤더
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(secondaryColor)
                
                TextField("애니메이션 검색", text: $searchText)
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
                                    .foregroundColor(index <= 3 ? primaryColor : secondaryColor)
                                    .frame(width: 20)
                                
                                Text("인기 애니메이션 \(index)")
                                    .font(.system(size: 16))
                                    .foregroundColor(textColor)
                                
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
                        searchResultsView()
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
    
    private func searchResultsView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("검색 결과가 없습니다.")
                .foregroundColor(secondaryColor)
                .padding(.horizontal)
            
            Text("현재 애니메이션 데이터를 준비 중입니다.")
                .foregroundColor(secondaryColor)
                .font(.caption)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 20)
    }
    
    // MARK: - Helper Methods
    
    private func refreshContent() async {
        isRefreshing = true
        
        // API가 있을 경우 여기서 데이터를 새로고침
        // 현재는 임시로 영화 데이터만 다시 가져옴
        await viewModel.fetchMovies()
        
        isRefreshing = false
    }
}

#Preview {
    AnimationTabView()
}
