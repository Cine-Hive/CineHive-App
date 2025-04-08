//
//  TopRatedMoviesViewModel.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import Foundation
import SwiftUI

@Observable
final class TopRatedMoviesViewModel {
    private(set) var movies: [Movie] = []
    private(set) var isLoading = false
    private(set) var error: String?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    @MainActor
    func fetchTopRatedMovies() async {
        do {
            isLoading = true
            error = nil
            movies = try await movieService.fetchTopRatedMovies()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    // 영화 제목 길이 자르기
    func formatTitle(_ title: String) -> String {
        return MovieFormatter.formatMovieTitle(title)
    }
    
    // 장르와 연도 텍스트 생성
    func genreAndYearText(for movie: Movie) -> String {
        let genres = MovieFormatter.formatMovieGenres(movie.genres)
        let year = MovieFormatter.extractMovieYear(from: movie.releaseDate)
        return "\(genres) • \(year)"
    }
    
    // 랜덤 평점 생성 (추후에는 평점 데이터 사용)
    func generateRating(for movie: Movie) -> String {
        return MovieFormatter.generateMovieRating(for: movie)
    }
    
    // 순위 계산
    func getRanking(for movie: Movie) -> Int {
        return (movies.firstIndex(where: { $0.id == movie.id })?.advanced(by: 1)) ?? 0
    }
    
    // OTT 서비스 아이콘 표시 여부 결정
    func shouldShowDisneyIcon(for movie: Movie) -> Bool {
        return movie.id % 2 == 0
    }
}
