//
//  NowPlayingMoviesViewModel.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import Foundation
import SwiftUI

@Observable
final class NowPlayingMoviesViewModel {
    private(set) var movies: [Movie] = []
    private(set) var isLoading = false
    private(set) var error: String?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    @MainActor
    func fetchNowPlayingMovies() async {
        do {
            isLoading = true
            error = nil
            movies = try await movieService.fetchNowPlayingMovies()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    // 영화 제목 포맷팅
    func formatTitle(_ title: String) -> String {
        return MovieFormatter.formatMovieTitle(title)
    }
    
    // 영화 개봉일 계산
    func getDaysFromRelease(for movie: Movie) -> String {
        guard let releaseDate = MovieFormatter.parseReleaseDate(movie.releaseDate) else {
            return "개봉"
        }
        
        let today = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: releaseDate, to: today)
        
        if let days = components.day {
            if days == 0 {
                return "오늘 개봉"
            } else if days < 0 {
                return "\(abs(days))일 후 개봉"
            } else {
                return "개봉 \(days)일차"
            }
        }
        
        return "개봉"
    }
    
    // 장르 포맷팅
    func formatGenres(for movie: Movie) -> String {
        return MovieFormatter.formatMovieGenres(movie.genres)
    }
    
    // 영화 평점 생성
    func generateRating(for movie: Movie) -> String {
        return MovieFormatter.generateMovieRating(for: movie)
    }
}
