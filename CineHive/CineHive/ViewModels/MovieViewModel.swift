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
    
    // Fetch movies from the service
    @MainActor
    func fetchMovies() {
        Task {
            do {
                isLoading = true
                error = nil
                
                movies = try await movieService.fetchMovies()
                
            } catch let error as NetworkError {
                self.error = error.errorDescription
            } catch {
                self.error = "알 수 없는 오류가 발생했습니다."
            }
            
            isLoading = false
        }
    }
    
    @MainActor
    func fetchNowPlayingMovies() {
        Task {
            do {
                isLoading = true
                error = nil
                
                movies = try await movieService.fetchNowPlayingMovies()
                
            } catch let error as NetworkError {
                self.error = error.errorDescription
            } catch {
                self.error = "알 수 없는 오류가 발생했습니다."
            }
            
            isLoading = false
        }
    }
    
    //@MainActor
    func fetchMovieDetail(movieId: Int) {
        Task {
            do {
                isLoading = true
                error = nil
                
                movieDetail = try await movieService.fetchMovieDetail(movieId: movieId)
            } catch let error as NetworkError {
                self.error = error.errorDescription
            } catch {
                self.error = "영화 디테일 정보를 불러오는 중 오류가 발생했습니다."
            }
            isLoading = false
        }
    }
    
    func getPosterURL(for movie: Movie) -> URL? {
        return movie.posterURL
    }
    
    
    func clearError() {
        error = nil
    }
    
//    func getMovies(forGenre genreId: Int) -> [Movie] {
//        movies.filter { $0.genreIds.contains(genreId) }
//    }
}
