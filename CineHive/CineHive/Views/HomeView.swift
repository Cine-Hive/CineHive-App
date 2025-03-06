//
//  HomeView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = MovieViewModel()
    
    // 넷플릭스 스타일 색상
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    
    // 샘플 배너 (테스트용!!)
    private let bannerItems: [BannerItem] = [
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg"),
            title: "오늘의 추천 영화",
            subtitle: "인셉션: 꿈 속의 꿈"
        ),
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500/8s4h9friP6Ci3adRGahHARVd76E.jpg"),
            title: "오늘의 추천 영화",
            subtitle: "인터스텔라: 우주 속의 꿈"
        )
    ]
    
    var body: some View {
        ZStack {
            // 배경색 설정
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 0) {
                    // 배너 섹션
                    netflixStyleBanner(items: bannerItems)
                    
                    // 카테고리별 영화 섹션
                    ForEach(MovieCategory.categories) { category in
                        VStack(alignment: .leading) {
                            Text(category.title)
                                .font(.title3)
                                .bold()
                                .foregroundColor(textColor)
                                .padding(.leading, 15)
                                .padding(.top, 30)
                            
                            // 기존의 HorizontalMovieListView 사용
                            HorizontalMovieListView(movies: viewModel.movies, movieType: category.type, viewModel: viewModel)
                                .padding(.leading, 15)
                        }
                    }
                }
            }
            .foregroundColor(textColor)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // 로고
            ToolbarItem(placement: .principal) {
                Text("CineHive")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(accentColor)
            }
            
            // 검색 버튼
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(textColor)
                }
            }
        }
        .onAppear {
            if viewModel.movies.isEmpty {
                viewModel.fetchMovies()
            }
        }
    }
    
    // 넷플릭스 스타일 배너
    private func netflixStyleBanner(items: [BannerItem]) -> some View {
        ZStack {
            TabView {
                ForEach(items) { item in
                    ZStack(alignment: .bottomLeading) {
                        // 배너 이미지
                        AsyncImage(url: item.imageURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(ProgressView().tint(.white))
                        }
                        .frame(height: 250)
                        
                        // 아래쪽 그라디언트 오버레이 (텍스트 가독성 향상)
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.clear,
                                backgroundColor.opacity(0.5),
                                backgroundColor.opacity(0.8),
                                backgroundColor
                            ]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(height: 250)
                        .allowsHitTesting(false)
                        
                        // 텍스트 및 버튼
                        VStack(alignment: .leading, spacing: 16) {
                            // 제목 정보
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.title)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text(item.subtitle)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.top, 2)
                            }
                            
                            // 태그들 (임시 데이터)
                            HStack(spacing: 8) {
                                Text("액션")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(3)
                                
                                Text("SF")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(3)
                                
                                Text("스릴러")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(3)
                            }
                            
                            // 버튼 행
                            HStack(spacing: 16) {
                                // 재생 버튼
                                Button(action: {}) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "play.fill")
                                        Text("재생")
                                            .fontWeight(.semibold)
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 8)
                                    .background(textColor)
                                    .foregroundColor(backgroundColor)
                                    .cornerRadius(4)
                                }
                                
                                // 내 리스트 버튼
                                Button(action: {}) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "plus")
                                        Text("내 리스트")
                                            .fontWeight(.medium)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.3))
                                    .foregroundColor(textColor)
                                    .cornerRadius(4)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 450)
        }
    }
    
    
    
}

#Preview {
    NavigationView {
        HomeView()
    }
}
