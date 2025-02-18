//
//  HomeView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = DummyViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(MovieCategory.categories) { category in
                    VStack(alignment: .leading) {
                        Text(category.title)
                            .font(.title2)
                            .bold()
                        HorizontalMovieListView(movies: viewModel.movies, movieType: category.type, viewModel: viewModel)
                    }
                }
                .padding(.leading, 15)
                .padding(.top, 30)
                
                .navigationTitle("CineHive")
                .onAppear {
                    if viewModel.movies.isEmpty {
                        viewModel.loadTrendingMovies()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
