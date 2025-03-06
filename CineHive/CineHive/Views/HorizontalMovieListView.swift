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
                            PosterView(posterURL: movie.posterURL, width: 120, height: 180)
                            
                        }
                    }
                }
            }
            .padding(.leading, 5)
            .padding(.trailing, 15)
        }
    }
}
