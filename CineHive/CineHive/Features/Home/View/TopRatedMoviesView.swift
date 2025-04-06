//
//  TopRatedMoviesView.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

// 평점 높은 영화 섹션 컴포넌트
struct TopRatedMoviesView: View {
    @State private var viewModel = TopRatedMoviesViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "평점 높은 영화", actionTitle: "더보기")
            
            if viewModel.isLoading {
                LoadingView()
            } else if !viewModel.movies.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.movies.prefix(10), id: \.id) { movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                topRatedMovieCard(movie: movie)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            } else {
                Text("영화를 불러올 수 없습니다.")
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 15)
        .task {
            await viewModel.fetchTopRatedMovies()
        }
    }
    
    // 최고 평점 영화 카드
    private func topRatedMovieCard(movie: Movie) -> some View {
        HStack(spacing: 15) {
            // 순위
            VStack(spacing: 3) {
                Text("\(viewModel.getRanking(for: movie))")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 30)
            }
            
            // 포스터
            PosterView(posterURL: movie.posterURL, width: 80, height: 120)
                .cornerRadius(4)
            
            // 정보
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.formatTitle(movie.title))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(2)
                    .frame(width: 160, alignment: .topLeading)
                
                // 장르 및 연도
                Text(viewModel.genreAndYearText(for: movie))
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
                // 평점
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 10))
                    
                    Text(viewModel.generateRating(for: movie))
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
                
                // OTT 서비스 아이콘
                HStack(spacing: 5) {
                    // 임의의 OTT 아이콘 표시
                    Image(systemName: "n.square.fill")
                        .foregroundColor(CHColors.OTT.netflix)
                        .font(.system(size: 12))
                    
                    if viewModel.shouldShowDisneyIcon(for: movie) {
                        Image(systemName: "d.square.fill")
                            .foregroundColor(CHColors.OTT.disney)
                            .font(.system(size: 12))
                    }
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color.clear)
        .contentShape(Rectangle())
    }
}

#Preview {
    TopRatedMoviesView(movies: [Movie.dummy1, Movie.dummy2, Movie.dummy3, Movie.dummy4, Movie.dummy5])
        .background(CHColors.backgroundColor)
}
