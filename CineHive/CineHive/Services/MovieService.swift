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
    private let movieDetailEndPoint = "/movies/"
    
    func fetchMovies() async throws -> [Movie] {
        return try await NetworkManager.shared.fetch(endpoint: moviesEndpoint)
    }
    
    func fetchNowPlayingMovies() async throws -> [Movie] { // 현재 상영작 불러오기 추가
        return try await NetworkManager.shared.fetch(endpoint: nowPlayingEndpoint)
    }
    
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetail {
        let endpoint = "\(movieDetailEndPoint)\(movieId)"
        
        do {
            print("🔵 영화 상세 정보 요청: \(endpoint)")
            
            let movieDetail: MovieDetail = try await NetworkManager.shared.fetch(endpoint: endpoint)
            
            print("🟢 응답 성공: \(movieDetail.title)")
            return movieDetail
        } catch let networkError as NetworkError {
            print("❌ 네트워크 오류 발생: \(networkError.errorDescription ?? "알 수 없는 오류")")
            throw networkError
        } catch {
            print("❌ 알 수 없는 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }


    
}
