//
//  MovieService.swift
//  CineHive
//
//  Created by 이종민 on 2/20/25.
//

import Foundation

final class MovieService {
    static let shared = MovieService()
    private init() {}

    private let moviesEndpoint = "/movies"
    private let nowPlayingEndpoint = "/now_playing"
    private let movieDetailEndPoint = "/movies/"
    private let popularMoviesEndpoint = "/get_popular_movies"
    private let topRatedMoviesEndpoint = "/get_topmovies"
    private let upcomingMoviesEndpoint = "/get_upcoming_movies"
    private let searchEndpoint = "/search"

    func fetchMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: moviesEndpoint)
    }

    func fetchNowPlayingMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: nowPlayingEndpoint)
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: popularMoviesEndpoint)
    }
    
    func fetchTopRatedMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: topRatedMoviesEndpoint)
    }
    
    func fetchUpcomingMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: upcomingMoviesEndpoint)
    }

    func fetchMovieDetail(movieId: Int) async throws -> MovieDetail {
        return try await NetworkManager.shared.fetch(endpoint: "\(movieDetailEndPoint)\(movieId)")
    }
    
    func fetchSimilarMovies(movieId: Int) async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: "\(movieDetailEndPoint)\(movieId)/similar")
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        let searchParams = ["query": query]
        return try await NetworkManager.shared.post(endpoint: searchEndpoint, body: searchParams)
    }
}
