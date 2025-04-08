//
//  PopularMoviesViewModel.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import Foundation
import SwiftUI

@Observable
final class PopularMoviesViewModel {
    private(set) var movies: [Movie] = []
    private(set) var isLoading = false
    private(set) var error: String?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    @MainActor
    func fetchPopularMovies() async {
        do {
            isLoading = true
            error = nil
            movies = try await movieService.fetchPopularMovies()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    // 영화 포맷팅 메서드들
    func formatTitle(_ title: String) -> String {
        return MovieFormatter.formatMovieTitle(title)
    }
    
    func generateRating(for movie: Movie) -> String {
        return MovieFormatter.generateMovieRating(for: movie)
    }
}

