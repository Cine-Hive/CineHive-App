//
//  UpcomingMoviesViewModel.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import Foundation
import SwiftUI

@Observable
final class UpcomingMoviesViewModel {
    private(set) var movies: [Movie] = []
    private(set) var isLoading = false
    private(set) var error: String?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    @MainActor
    func fetchUpcomingMovies() async {
        do {
            isLoading = true
            error = nil
            movies = try await movieService.fetchUpcomingMovies()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    // 영화 제목 포맷팅
    func formatTitle(_ title: String) -> String {
        return MovieFormatter.formatMovieTitle(title)
    }
    
    // 개봉 예정일까지 남은 기간 계산
    func getDaysUntilRelease(for movie: Movie) -> String {
        guard let releaseDate = MovieFormatter.parseReleaseDate(movie.releaseDate) else {
            return "개봉 예정"
        }
        
        let today = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: today, to: releaseDate)
        
        if let days = components.day {
            if days == 0 {
                return "오늘 개봉"
            } else if days < 0 {
                return "개봉"
            } else if days == 1 {
                return "D-1"
            } else {
                return "D-\(days)"
            }
        }
        
        return "개봉 예정"
    }
    
    // 장르 포맷팅
    func formatGenres(for movie: Movie) -> String {
        return MovieFormatter.formatMovieGenres(movie.genres)
    }
}
