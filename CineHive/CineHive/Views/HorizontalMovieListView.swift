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
    @ObservedObject var viewModel: DummyViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(movies, id: \.id) { movie in
                    NavigationLink(destination: {
                        //DetailView로 이동
                    }, label: {
                        VStack {
                            if let posterURL = movie.posterURL {
                                AsyncImage(url: posterURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 100, height: 150)
                                        .overlay(
                                            ProgressView() // 로딩 인디케이터
                                        )
                                        .cornerRadius(8)
                                }
                                .cornerRadius(8)
                                .frame(width: 100, height: 150)
                            }
                        }
                    })
                }
            }
        }
    }
}

