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
    
    @MainActor
    func fetchMovieDetail(movieId: Int) {
        Task {
            do {
                isLoading = true
                error = nil

                print("🔵 영화 상세 정보 요청 시작 (ID: \(movieId))")
                movieDetail = try await movieService.fetchMovieDetail(movieId: movieId)

                if let movieDetail = movieDetail {
                    print("✅ 영화 세부정보 로드 성공: \(movieDetail.title)")

                    if movieDetail.actors.isEmpty {
                        print("⚠️ 배우 정보가 없음")
                    }
                } else {
                    print("⚠️ movieDetail이 nil입니다. 에러를 설정합니다.")
                    self.error = "영화 정보를 불러오지 못했습니다."
                }
            } catch let error as NetworkError {
                self.error = error.errorDescription
                print("❌ 네트워크 오류 발생: \(String(describing: error.errorDescription))")
            } catch {
                self.error = "영화 디테일 정보를 불러오는 중 오류가 발생했습니다."
                print("❌ 알 수 없는 오류 발생: \(error.localizedDescription)")
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
