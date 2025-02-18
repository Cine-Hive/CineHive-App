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
                // 오늘의 추천 영화 (배너)
                ZStack(alignment: .bottomLeading) {
                    // 배너 이미지 (샘플 URL 사용)
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w500/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg")
                    ) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                ProgressView()
                            )
                    }
                    .frame(height: 220)
                    .clipped()
                    
                    // 아래쪽 그라디언트 오버레이 (텍스트 가독성 향상)
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .frame(height: 100)
                    .allowsHitTesting(false)
                    
                    // 추천 영화 텍스트
                    VStack(alignment: .leading, spacing: 5) {
                        Text("오늘의 추천 영화")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("인셉션: 꿈 속의 꿈")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 2)
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 12)
                }
                
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
