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
        guard var components = URLComponents(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        print("🌍 요청 URL: \(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("📡 서버 응답 코드: \(httpResponse.statusCode)")

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
        }

        // JSON 데이터 출력
        if let jsonString = String(data: data, encoding: .utf8) {
            //print("📄 서버 응답 데이터: \(jsonString)")
        } else {
            print("⚠️ 응답 데이터를 문자열로 변환할 수 없음")
        }

        // JSONDecoder 설정 추가
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys // 기본적으로 Snake Case → Camel Case 변환 방지
        decoder.dateDecodingStrategy = .iso8601 // 날짜 형식 설정

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ JSON 디코딩 오류: \(error.localizedDescription)")
            throw NetworkError.decodingError(error)
        }
    }



}

