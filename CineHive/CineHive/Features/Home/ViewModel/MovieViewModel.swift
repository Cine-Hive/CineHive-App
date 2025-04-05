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
    
    // 에러 처리
    var error: String?
    
    // 각 카테고리별 영화 데이터
    private(set) var nowPlayingMovies: [Movie] = []
    private(set) var popularMovies: [Movie] = []
    private(set) var topRatedMovies: [Movie] = []
    private(set) var upcomingMovies: [Movie] = []
    
    // 검색 결과
    private(set) var searchResults: [Movie] = []
    
    // 로그인 상태 및 사용자 정보
    var isLoggedIn: Bool = false
    var currentUser: UserData? = nil
    
    private let movieService: MovieService
    
    init(movieService: MovieService = .shared) {
        self.movieService = movieService
    }
    
    @MainActor
    func fetchMovies() async {
        performNetworkRequest {
            self.movies = try await self.movieService.fetchMovies()
        }
    }
    
    @MainActor
    func fetchNowPlayingMovies() async {
        performNetworkRequest {
            self.nowPlayingMovies = try await self.movieService.fetchNowPlayingMovies()
        }
    }
    
    @MainActor
    func fetchPopularMovies() async {
        performNetworkRequest {
            self.popularMovies = try await self.movieService.fetchPopularMovies()
        }
    }
    
    @MainActor
    func fetchTopRatedMovies() async {
        performNetworkRequest {
            self.topRatedMovies = try await self.movieService.fetchTopRatedMovies()
        }
    }
    
    @MainActor
    func fetchUpcomingMovies() async {
        performNetworkRequest {
            self.upcomingMovies = try await self.movieService.fetchUpcomingMovies()
        }
    }
    
    @MainActor
    func fetchMovieDetail(movieId: Int) async {
        performNetworkRequest {
            self.movieDetail = try await self.movieService.fetchMovieDetail(movieId: movieId)
        }
    }
    
    @MainActor
    func searchMovies(query: String) async {
        // 검색어가 비어있으면 결과 초기화
        guard !query.isEmpty else {
            self.searchResults = []
            return
        }
        
        performNetworkRequest {
            // 현재는 로컬 필터링으로 임시 구현
            // 추후 실제 검색 API가 구현되면 그것을 사용하도록 변경
            self.filterMoviesLocally(query: query)
        }
    }
    
    // 로컬 영화 필터링 - 복잡한 표현식을 분리함
    private func filterMoviesLocally(query: String) {
        // 기존 영화 데이터들을 합침
        var combinedMovies: [Movie] = []
        combinedMovies.append(contentsOf: self.movies)
        combinedMovies.append(contentsOf: self.nowPlayingMovies)
        combinedMovies.append(contentsOf: self.popularMovies)
        combinedMovies.append(contentsOf: self.topRatedMovies)
        combinedMovies.append(contentsOf: self.upcomingMovies)
        
        // 중복 제거
        let uniqueIds = Set(combinedMovies.map { $0.id })
        var uniqueMovies: [Movie] = []
        
        for id in uniqueIds {
            if let movie = combinedMovies.first(where: { $0.id == id }) {
                uniqueMovies.append(movie)
            }
        }
        
        // 실제 ID 기반 필터링 (영화 제목이 없으므로 ID로 필터링)
        // 나중에 여기서 영화 제목이나 기타 속성으로 필터링해야 함
        let lowercaseQuery = query.lowercased()
        searchResults = uniqueMovies.filter { movie in
            return String(movie.id).contains(lowercaseQuery)
        }
    }
    
    // 사용자 관련 기능
    func login(email: String, password: String) async -> Bool {
        do {
            let loginData = LoginUser(email: email, password: password)
            let response: LoginResponse = try await UserService.shared.loginUser(user: loginData)
            isLoggedIn = true
            currentUser = response.user
            return true
        } catch {
            return false
        }
    }
    
    func logout() {
        isLoggedIn = false
        currentUser = nil
    }
    
    func showError(_ error: Error) {
        let uiError = ErrorMapper.map(error)
        self.error = uiError.errorDescription
    }
    
    func clearError() {
        self.error = nil
    }
    
    @MainActor
    private func performNetworkRequest(_ task: @escaping @Sendable () async throws -> Void) {
        Task {
            do {
                isLoading = true
                error = nil
                try await task()
            } catch {
                showError(error)
            }
            isLoading = false
        }
    }
}
