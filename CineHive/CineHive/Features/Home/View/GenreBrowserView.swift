//
//  GenreBrowserView.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import SwiftUI

// 장르별 탐색 섹션 컴포넌트
struct GenreBrowserView: View {
    @State private var viewModel = GenreBrowserViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("장르별 탐색")
                .font(.title3)
                .bold()
                .foregroundColor(CHColors.textColor)
                .padding(.leading, 15)
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    // 주요 장르 선택 버튼
                    ForEach(viewModel.genres, id: \.self) { genre in
                        genreButton(genre: genre, isSelected: viewModel.selectedGenre == genre) {
                            // 장르 선택 시 액션
                            withAnimation {
                                viewModel.selectGenre(genre)
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            
            // 선택된 장르가 있을 경우 장르별 영화 표시
            if let genre = viewModel.selectedGenre {
                genreMoviesPreview(genre: genre, movies: viewModel.getMoviesForSelectedGenre())
            }
        }
    }
    
    // 장르별 영화 미리보기 (선택된 장르가 있을 경우)
    private func genreMoviesPreview(genre: String, movies: [Movie]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("\(genre) 영화")
                    .font(.headline)
                    .foregroundColor(CHColors.textColor)
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(0.7)
                }
            }
            .padding(.horizontal, 15)
            .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    if !movies.isEmpty {
                        ForEach(movies) { movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                genreMovieCard(movie: movie)
                            }
                        }
                    } else {
                        Text("이 장르의 영화가 없습니다")
                            .font(.subheadline)
                            .foregroundColor(CHColors.gray)
                            .padding(.horizontal, 15)
                    }
                }
                .padding(.horizontal, 15)
            }
        }
        .transition(.opacity)
    }
    
    // 장르 영화 카드
    private func genreMovieCard(movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            // 포스터 이미지
            PosterView(posterURL: movie.posterURL, width: 120, height: 180)
                .cornerRadius(8)
            
            Text(movie.title)
                .font(.system(size: 14))
                .foregroundColor(CHColors.textColor)
                .lineLimit(1)
                .frame(width: 120, alignment: .leading)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(CHColors.starColor)
                    .font(.system(size: 12))
                
                // 평점
                Text(viewModel.generateRating(for: movie))
                    .font(.system(size: 12))
                    .foregroundColor(CHColors.secondaryColor)
            }
        }
    }
    
    // 장르 버튼
    private func genreButton(genre: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(genre)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? CHColors.primaryColor : Color.gray.opacity(0.3))
                .foregroundColor(CHColors.textColor)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: isSelected ? 0 : 1)
                )
                .shadow(color: isSelected ? CHColors.primaryColor.opacity(0.5) : Color.clear, radius: 5)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

#Preview {
    GenreBrowserView()
        .background(CHColors.backgroundColor)
}
