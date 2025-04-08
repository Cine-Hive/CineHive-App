//
//  PopularMovieCard.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

struct PopularMoviesView: View {
    @State private var viewModel = PopularMoviesViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "인기 영화", actionTitle: "더보기")
            
            if viewModel.isLoading {
                LoadingView()
            } else if !viewModel.movies.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(Array(viewModel.movies.prefix(10).enumerated()), id: \.offset) { index, movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                popularMovieCard(movie: movie, rank: index + 1)
                            }
                        }
                    }
                }
            } else {
                Text("영화를 불러올 수 없습니다.")
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 30)
        .task {
            await viewModel.fetchPopularMovies()
        }
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
                Text(viewModel.formatTitle(movie.title))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(1)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 12))
                    
                    Text(viewModel.generateRating(for: movie))
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

#Preview {
    PopularMoviesView()
        .background(CHColors.backgroundColor)
}
