//
//  UpcomingMoviesView.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import SwiftUI

struct UpcomingMoviesView: View {
    @State private var viewModel = UpcomingMoviesViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "개봉 예정작", actionTitle: "더보기")
            
            if viewModel.isLoading {
                LoadingView()
            } else if !viewModel.movies.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(viewModel.movies.prefix(10), id: \.id) { movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                upcomingMovieCard(movie: movie)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            } else {
                Text("개봉 예정작이 없습니다.")
                    .foregroundColor(CHColors.gray)
                    .padding()
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 15)
        .task {
            await viewModel.fetchUpcomingMovies()
        }
    }
    
    // 개봉 예정작 카드
    private func upcomingMovieCard(movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // 포스터 이미지
            ZStack(alignment: .topLeading) {
                PosterView(posterURL: movie.posterURL, width: 140, height: 210)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                
                // D-day 배지
                Text(viewModel.getDaysUntilRelease(for: movie))
                    .font(.system(size: 11, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(CHColors.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .padding(8)
            }
            
            // 영화 제목
            Text(viewModel.formatTitle(movie.title))
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(CHColors.textColor)
                .lineLimit(1)
                .frame(width: 140, alignment: .leading)
            
            // 장르 및 개봉일 정보
            HStack(spacing: 4) {
                // 개봉일
                Text(MovieFormatter.extractMovieYear(from: movie.releaseDate))
                    .font(.system(size: 12))
                    .foregroundColor(CHColors.secondaryColor)
                
                Text("•")
                    .font(.system(size: 10))
                    .foregroundColor(CHColors.secondaryColor)
                
                // 장르
                Text(viewModel.formatGenres(for: movie))
                    .font(.system(size: 12))
                    .foregroundColor(CHColors.secondaryColor)
                    .lineLimit(1)
            }
            .frame(width: 140, alignment: .leading)
        }
    }
}

#Preview {
    UpcomingMoviesView()
        .background(CHColors.backgroundColor)
}
