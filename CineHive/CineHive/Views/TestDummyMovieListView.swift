//
//  TestDummyMovieListView.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import SwiftUI

struct TestDummyMovieListView: View {
    @StateObject private var viewModel = DummyViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                HStack(alignment: .top, spacing: 16) {
                    // 영화 포스터 이미지
                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 150)
                            .clipped()
                            .cornerRadius(8)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 150)
                            .overlay(
                                ProgressView() // 로딩 인디케이터
                            )
                            .cornerRadius(8)
                    }
                    
                    // 영화 정보
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.headline)
                            .lineLimit(2)
                        Text(movie.overview)
                            .font(.subheadline)
                            .lineLimit(3)
                            .foregroundColor(.secondary)
                        Text("Release Date: \(movie.releaseDate)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Trending Movies")
            .onAppear {
                if viewModel.movies.isEmpty {
                    viewModel.loadTrendingMovies()
                }
            }
        }
    }
}

#Preview {
    TestDummyMovieListView()
}
