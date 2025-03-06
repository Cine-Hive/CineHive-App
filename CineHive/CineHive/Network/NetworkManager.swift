//
//  NetworkManager.swift
//  CineHive
//
//  Created by 이종민 on 2/19/25.
//

import Foundation
import OSLog

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case badResponse(statusCode: Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .badResponse(let statusCode):
            return "서버 응답 오류: 상태코드 \(statusCode)"
        case .decodingError(let error):
            return "디코딩 실패: \(error.localizedDescription)"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURL: String = "http://localhost:8081"

    private init() { }

    func request<T: Decodable>(endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var components = URLComponents(string: "\(NetworkManager.baseURL)\(endpoint)") else {
            Logger.log(.error, category: Logger.networking, message: "잘못된 URL: \(endpoint)")
            throw NetworkError.invalidURL
        }

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            Logger.log(.error, category: Logger.networking, message: "URL 변환 실패: \(components.string ?? "N/A")")
            throw NetworkError.invalidURL
        }

        Logger.log(.info, category: Logger.networking, message: "요청 URL: \(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }

            Logger.log(.info, category: Logger.networking, message: "서버 응답 코드: \(httpResponse.statusCode)")

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            decoder.dateDecodingStrategy = .iso8601

            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            Logger.log(.error, category: Logger.networking, message: "JSON 디코딩 오류: \(decodingError.localizedDescription)")
            throw NetworkError.decodingError(decodingError)
        } catch {
            Logger.log(.error, category: Logger.networking, message: "네트워크 요청 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
