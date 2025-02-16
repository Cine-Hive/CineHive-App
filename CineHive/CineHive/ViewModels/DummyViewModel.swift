//
//  DummyViewModel.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import Foundation

class DummyViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    /// 일간 트렌드 영화 로드하는 함수
    func loadTrendingMovies() {
        guard let url = Bundle.main.url(forResource: "TrendingMoviesDummyData", withExtension: "json") else {
            print("Failed to locate TrendingMoviesDummyData.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            self.movies = movieResponse.results
            print("Trending movies loaded successfully.")
        } catch {
            print("Failed to decode TrendingMoviesDummyData.json: \(error)")
        }
    }
}
