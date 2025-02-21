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
    
    // 서버의 /movies 엔드포인트 (baseURL은 NetworkManager에서 설정된 "http://localhost:8081" 사용)
    private let moviesEndpoint = "/movies"
    private let nowPlayingEndpoint = "/now_playing"
    
    func fetchMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: moviesEndpoint)
    }
    
    func fetchNowPlayingMovies() async throws -> [Movie] { // 현재 상영작 불러오기 추가
        return try await NetworkManager.shared.fetch(endpoint: nowPlayingEndpoint)
    }
    
}
