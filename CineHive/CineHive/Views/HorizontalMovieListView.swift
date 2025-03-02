//
//  HorizontalMovieListView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HorizontalMovieListView: View {
    let movies: [Movie]
    let movieType: MovieListType
    @State var viewModel: MovieViewModel
    
    // 넷플릭스 스타일 색상
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(movies, id: \.id) { movie in
                    NavigationLink(destination: DetailView(movieId: movie.id)) {
                        VStack(alignment: .leading, spacing: 6) {
                            // 포스터 이미지
                            netflixStylePosterView(posterURL: movie.posterURL, width: 120, height: 180)
                            
                            // 평점
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 5)
            .padding(.trailing, 15)
        }
    }
}

// 넷플릭스 스타일 포스터 뷰
private func netflixStylePosterView(posterURL: URL?, width: CGFloat, height: CGFloat) -> some View {
    AsyncImage(url: posterURL) { phase in
        switch phase {
        case .empty:
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: width, height: height)
                .cornerRadius(5)
                .overlay(ProgressView().tint(.white))
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .cornerRadius(5)
                .shadow(radius: 2)
        case .failure:
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: width, height: height)
                .cornerRadius(5)
                .overlay(
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                )
        @unknown default:
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: width, height: height)
                .cornerRadius(5)
        }
    }
}
