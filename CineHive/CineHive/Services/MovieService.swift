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

    func fetchMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.request(endpoint: moviesEndpoint)
    }

    func fetchNowPlayingMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.request(endpoint: nowPlayingEndpoint)
    }

    func fetchMovieDetail(movieId: Int) async throws -> MovieDetail {
        return try await NetworkManager.shared.request(endpoint: "\(movieDetailEndPoint)\(movieId)")
    }
}
