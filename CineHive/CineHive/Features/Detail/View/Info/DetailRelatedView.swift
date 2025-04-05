//
//  DetailRelatedView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailRelatedView: View {
    private let textColor = Color.white
    private let secondaryTextColor = Color.gray
    
    // 더미 영화 데이터
    private let relatedMovies: [Movie] = [
        .dummy1, .dummy2, .dummy3, .dummy4, .dummy5, .dummy6
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("비슷한 콘텐츠")
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 16)
                .foregroundStyle(textColor)
            
            relatedMoviesRow(title: "장르가 비슷한 영화", movies: relatedMovies)
            relatedMoviesRow(title: "같은 감독의 영화", movies: relatedMovies.shuffled())
            relatedMoviesRow(title: "팬들이 좋아하는 영화", movies: relatedMovies.shuffled())
        }
    }
    
    //MARK: - 관련 영화 행 (포스터 추가)
    private func relatedMoviesRow(title: String, movies: [Movie]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 16)
                .foregroundStyle(textColor)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(movies) { movie in
                        VStack(alignment: .leading, spacing: 6) {
                            PosterView(posterURL: movie.posterURL, width: 120, height: 180)

                            // 제목
                            Text("영화 제목")
                                .font(.system(size: 14))
                                .foregroundColor(textColor)
                                .lineLimit(1)
                                .frame(width: 120, alignment: .leading)
                            
                            // 평점
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                                Text(String(format: "%.1f", Double.random(in: 6.0...9.8)))
                                    .font(.system(size: 12))
                                    .foregroundColor(secondaryTextColor)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    DetailRelatedView()
        .background(.black)
}
