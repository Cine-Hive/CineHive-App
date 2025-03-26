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
    case encodingError(Error)
    case networkError(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .badResponse(let statusCode):
            return "서버 응답 오류: 상태코드 \(statusCode)"
        case .decodingError(let error):
            return "디코딩 실패: \(error.localizedDescription)"
        case .encodingError(let error):
            return "인코딩 실패: \(error.localizedDescription)"
        case .networkError(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURL: String = "http://localhost:8081"

    private init() { }

    func fetch<T: Decodable>(endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
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
            throw NetworkError.networkError(error)
        }
    }
    
    // 공통 POST 요청 함수
    func post<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        guard let url = URL(string: "\(NetworkManager.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encodable 데이터 -> JSON 형식 변환
        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(body)
        } catch {
            throw NetworkError.encodingError(error)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("서버 응답 메시지: \(responseString)")
                }
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("서버 응답 원본 데이터: \(responseString)")
                }
                throw NetworkError.decodingError(error)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.networkError(error)
        }
    }
    
    // DELETE 요청 함수
    func delete(endpoint: String) async throws {
        guard let url = URL(string: "\(NetworkManager.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.networkError(error)
        }
    }
    
    // PUT 요청 함수
    func put<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        guard let url = URL(string: "\(NetworkManager.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encodable 데이터 -> JSON 형식 변환
        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(body)
        } catch {
            throw NetworkError.encodingError(error)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.networkError(error)
        }
    }
}
