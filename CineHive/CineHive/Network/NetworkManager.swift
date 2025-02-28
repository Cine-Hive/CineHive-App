//
//  NetworkManager.swift
//  CineHive
//
//  Created by 이종민 on 2/19/25.
//

import Foundation

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
    private let baseURL: String
    
    private init() {
        // 로컬 서버 주소로 기본 URL 설정
        self.baseURL = "http://localhost:8081"
    }
    
    func fetch<T: Decodable>(endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        // baseURL와 엔드포인트를 합쳐 URLComponents 생성
        guard var components = URLComponents(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        // URLRequest 구성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // 로컬 서버로 요청하는 경우 별도의 인증 헤더가 필요하지 않다면 생략
        
        // 데이터 요청 및 응답 처리
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
        }
        
        // JSON 디코딩 처리
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    // 공통 POST 요청 함수
    func post<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encodable 데이터 -> JSON 형식 변환
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(body) else {
            throw NetworkError.decodingError(NSError(domain: "Encoding Error", code: -1, userInfo: nil))
        }
        
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if let responseString = String(data: data, encoding: .utf8) {
                print("서버 응답 메시지: \(responseString)") // 서버가 반환한 오류 메시지를 확인
            }
            throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if let responseString = String(data: data, encoding: .utf8) {
                print("서버 응답 원본 데이터: \(responseString)") // 서버가 보낸 데이터를 확인
            }
            throw NetworkError.decodingError(error)
        }
    }
}

