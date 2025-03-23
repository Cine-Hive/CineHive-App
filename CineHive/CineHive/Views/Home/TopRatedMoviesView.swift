//
//  TopRatedMoviesView.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

// 평점 높은 영화 섹션 컴포넌트
struct TopRatedMoviesView: View {
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "평점 높은 영화", actionTitle: "더보기")
            
            if !movies.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(movies.prefix(10), id: \.id) { movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                topRatedMovieCard(movie: movie)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            } else {
                Text("로딩 중...")
                    .foregroundColor(CHColors.secondaryColor)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 15)
    }
    
    // 최고 평점 영화 카드
    private func topRatedMovieCard(movie: Movie) -> some View {
        HStack(spacing: 15) {
            // 순위
            VStack(spacing: 3) {
                Text("\(movies.firstIndex(where: { $0.id == movie.id })?.advanced(by: 1) ?? 0)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 30)
            }
            
            
            // 포스터
            PosterView(posterURL: movie.posterURL, width: 80, height: 120)
                .cornerRadius(4)
            
            // 정보
            VStack(alignment: .leading, spacing: 4) {
                Text("영화 제목")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(1)
                
                // 장르 및 연도 (임시 데이터)
                Text("액션 • 드라마 • 2023")
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
                
                // 평점
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 10))
                    
                    Text(String(format: "%.1f", 8.0 + Double(movie.id % 20) / 10))
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
                
                // OTT 서비스 아이콘
                HStack(spacing: 5) {
                    // 임의의 OTT 아이콘 표시
                    Image(systemName: "n.square.fill")
                        .foregroundColor(CHColors.OTT.netflix)
                        .font(.system(size: 12))
                    
                    if movie.id % 2 == 0 {
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
