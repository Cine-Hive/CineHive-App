//
//  HomeView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = DummyViewModel()
    
    // 샘플 배너 (테스트용!!)
    private let bannerItems: [BannerItem] = [
            BannerItem(
                imageURL: URL(string: "https://image.tmdb.org/t/p/w500/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg"),
                title: "오늘의 추천 영화",
                subtitle: "인셉션: 꿈 속의 꿈"
            ),
            BannerItem(
                imageURL: URL(string: "https://image.tmdb.org/t/p/w500/8s4h9friP6Ci3adRGahHARVd76E.jpg"),
                title: "오늘의 추천 영화",
                subtitle: "인터스텔라: 우주 속의 꿈"
            )
        ]
    
    var body: some View {
        ScrollView{
            VStack {
                RecommendedMovieBanner(items: bannerItems)
                
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
