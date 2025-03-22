//
//  HorizontalMovieListView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct MovieListView: View {
    let movies: [Movie]
    let movieType: MovieListType
    @State var viewModel: MovieViewModel
    
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(movies, id: \.id) { movie in
                    NavigationLink(destination: DetailView(movieId: movie.id)) {
                        VStack(alignment: .leading, spacing: 6) {
                            // 포스터 이미지
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
                                    .foregroundColor(secondaryColor)
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

#Preview {
    MovieListView(movies: Movie.dummyMovies, movieType: .popular, viewModel: MovieViewModel())
        .background(.black)
}
