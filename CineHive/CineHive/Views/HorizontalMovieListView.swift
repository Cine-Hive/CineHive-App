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
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(movies, id: \.id) { movie in
                    NavigationLink(destination: DetailView(movie: movie)) {
                        VStack {
                            PosterView(posterURL: movie.posterURL)
                        }
                    }
                }
            }
        }
    }
}

