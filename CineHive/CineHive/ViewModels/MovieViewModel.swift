//
//  MovieViewModel.swift
//  CineHive
//
//  Created by 이종민 on 2/20/25.
//

import Foundation
import Observation

@Observable
final class MovieViewModel {
    private(set) var movies: [Movie] = []
    private(set) var movieDetail: MovieDetail?
    private(set) var isLoading = false
    private(set) var error: String?

    private let movieService: MovieService

    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }

    @MainActor
    func fetchMovies() {
        performNetworkRequest {
            self.movies = try await self.movieService.fetchMovies()
        }
    }

    @MainActor
    func fetchNowPlayingMovies() {
        performNetworkRequest {
            self.movies = try await self.movieService.fetchNowPlayingMovies()
        }
    }

    

    @MainActor
    private func performNetworkRequest(_ task: @escaping @Sendable () async throws -> Void) {
        Task {
            do {
                isLoading = true
                error = nil
                try await task()
            } catch let error as NetworkError {
                self.error = error.errorDescription
            } catch {
                self.error = "알 수 없는 오류가 발생했습니다."
            }
            isLoading = false
        }
    }
}
