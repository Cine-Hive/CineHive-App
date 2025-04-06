//
//  PopularMovieCard.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

struct PopularMoviesView: View {
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "인기 영화", actionTitle: "더보기")
            
            if !movies.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        //랭크 정보가 없어서 그냥 받아온 순서대로 순위 매김
                        ForEach(Array(movies.prefix(10).enumerated()), id: \.offset) { index, movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                popularMovieCard(movie: movie, rank: index + 1)
                            }
                        }
                    }
                }
            } else {
                LoadingView()
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 30)
    }
    
    private func popularMovieCard(movie: Movie, rank: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topLeading) {
                PosterView(posterURL: movie.posterURL, width: 170, height: 240)
                    .cornerRadius(10)
                
                ZStack {
                    Circle()
                        .fill(CHColors.primaryColor)
                        .frame(width: 28, height: 28)
                    
                    Text("\(rank)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
                .offset(x: 5, y: 5)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(1)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 12))
                    
                    Text(String(format: "%.1f", Double.random(in: 7.0...9.5)))
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

#Preview {
    PopularMoviesView(movies: [Movie.dummy1, Movie.dummy2, Movie.dummy3, Movie.dummy4])
        .background(CHColors.backgroundColor)
}
