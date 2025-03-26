//
//  DramaService.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import Foundation

// MARK: - 드라마 서비스
final class DramaService {
    static let shared = DramaService()
    private init() {}
    
    /// 드라마 목록 조회
    func fetchDramas() async throws -> [Drama] {
        return try await NetworkManager.shared.fetch(endpoint: "/dramas")
    }
    
    /// 드라마 상세 정보 조회
    func fetchDramaDetail(id: Int) async throws -> Drama {
        return try await NetworkManager.shared.fetch(endpoint: "/dramas/\(id)")
    }
}
