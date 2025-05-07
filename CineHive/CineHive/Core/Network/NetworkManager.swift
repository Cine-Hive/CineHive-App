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
    case unauthorized
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
        case .unauthorized:
            return "인증 정보가 유효하지 않습니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    // MARK: - 기본 GET 요청
    
    func fetch<T: Decodable>(endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var components = URLComponents(string: "\(EndPoint.baseURL)\(endpoint)") else {
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
        request.httpMethod = HTTPMethod.GET.rawValue
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }
            
            Logger.log(.info, category: Logger.networking, message: "서버 응답 코드: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 401 {
                    throw NetworkError.unauthorized
                }
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
    
    // MARK: - 기본 POST 요청
    
    func post<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        guard let url = URL(string: "\(EndPoint.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
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
                if httpResponse.statusCode == 401 {
                    throw NetworkError.unauthorized
                }
                if let responseString = String(data: data, encoding: .utf8) {
                    Logger.log(.error, category: Logger.networking, message: "서버 응답 메시지: \(responseString)")
                }
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
            
            do {
                return try decodeResponse(data: data, response: httpResponse)
            } catch let decodingError as DecodingError {
                if let responseString = String(data: data, encoding: .utf8) {
                    Logger.log(.error, category: Logger.networking, message: "서버 응답 원본 데이터: \(responseString)")
                }
                throw NetworkError.decodingError(decodingError)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.networkError(error)
        }
    }
    
    // MARK: - 기본 DELETE 요청
    
    func delete(endpoint: String) async throws {
        guard let url = URL(string: "\(EndPoint.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 401 {
                    throw NetworkError.unauthorized
                }
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.networkError(error)
        }
    }
    
    // MARK: - 기본 PUT 요청
    
    func put<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        guard let url = URL(string: "\(EndPoint.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.PUT.rawValue
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
                if httpResponse.statusCode == 401 {
                    throw NetworkError.unauthorized
                }
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
    
    // MARK: - 인증된 요청 메서드
    
    /// 인증된 GET 요청
    func authenticatedFetch<T: Decodable>(endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var components = URLComponents(string: "\(EndPoint.baseURL)\(endpoint)") else {
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
        
        Logger.log(.info, category: Logger.networking, message: "인증된 GET 요청 URL: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // 인증 토큰 추가
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            throw NetworkError.unauthorized
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }
            
            Logger.log(.info, category: Logger.networking, message: "서버 응답 코드: \(httpResponse.statusCode)")
            
            // 401 오류의 경우 자동 로그아웃 처리
            if httpResponse.statusCode == 401 {
                Task { @MainActor in
                    UserState.shared.logout()
                }
                throw NetworkError.unauthorized
            }
            
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
    
    /// 인증된 POST 요청
    func authenticatedPost<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        guard let url = URL(string: "\(EndPoint.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 인증 토큰 추가
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            throw NetworkError.unauthorized
        }
        
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
            
            // 401 오류의 경우 자동 로그아웃 처리
            if httpResponse.statusCode == 401 {
                Task { @MainActor in
                    UserState.shared.logout()
                }
                throw NetworkError.unauthorized
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if let responseString = String(data: data, encoding: .utf8) {
                    Logger.log(.error, category: Logger.networking, message: "서버 응답 메시지: \(responseString)")
                }
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
            
            do {
                return try decodeResponse(data: data, response: httpResponse)
            } catch let decodingError as DecodingError {
                if let responseString = String(data: data, encoding: .utf8) {
                    Logger.log(.error, category: Logger.networking, message: "서버 응답 원본 데이터: \(responseString)")
                }
                throw NetworkError.decodingError(decodingError)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.networkError(error)
        }
    }
    
    /// 인증된 DELETE 요청
    func authenticatedDelete<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(EndPoint.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        
        // 인증 토큰 추가
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            throw NetworkError.unauthorized
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: 0)
            }
            
            // 401 오류의 경우 자동 로그아웃 처리
            if httpResponse.statusCode == 401 {
                Task { @MainActor in
                    UserState.shared.logout()
                }
                throw NetworkError.unauthorized
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.networkError(error)
        }
    }
    
    /// 인증된 PUT 요청
    func authenticatedPut<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        guard let url = URL(string: "\(EndPoint.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.PUT.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 인증 토큰 추가
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            throw NetworkError.unauthorized
        }
        
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
            
            // 401 오류의 경우 자동 로그아웃 처리
            if httpResponse.statusCode == 401 {
                Task { @MainActor in
                    UserState.shared.logout()
                }
                throw NetworkError.unauthorized
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

// 추가 확장: 응답 결과가 없는 경우를 위한 메서드
extension NetworkManager {
    func post<U: Encodable>(endpoint: String, body: U) async throws {
        let _: EmptyResponse = try await post(endpoint: endpoint, body: body)
    }
    
    func authenticatedPost<U: Encodable>(endpoint: String, body: U) async throws {
        let _: EmptyResponse = try await authenticatedPost(endpoint: endpoint, body: body)
    }
}

// 빈 응답을 위한 더미 struct
struct EmptyResponse: Codable {}
