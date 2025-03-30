//
//  ErrorMapper.swift
//  CineHive
//
//  Created by 이종민 on 3/23/25.
//

import Foundation

enum UIError: LocalizedError {
    case noInternet
    case serverError
    case decodingFailed
    case requestFailed
    case unauthorized
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "인터넷 연결이 끊겼어요.\n연결 상태를 확인해주세요."
        case .serverError:
            return "서버가 바빠요.\n잠시 후 다시 시도해주세요."
        case .decodingFailed:
            return "데이터를 불러오는데 실패했어요."
        case .requestFailed:
            return "요청을 처리하지 못했어요."
        case .unauthorized:
            return "로그인이 필요하거나 인증 정보가 만료되었어요."
        case .unknown:
            return "알 수 없는 오류가 발생했어요."
        }
    }
}

struct ErrorMapper {
    static func map(_ error: Error) -> UIError {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidURL, .encodingError:
                return .requestFailed
            case .badResponse:
                return .serverError
            case .decodingError:
                return .decodingFailed
            case .networkError(let underlying):
                if let urlError = underlying as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        return .noInternet
                    case .timedOut:
                        return .serverError
                    default:
                        return .requestFailed
                    }
                }
                return .requestFailed
            case .unauthorized:
                return .unauthorized
            case .unknown:
                return .unknown
            }
        }
        return .unknown
    }
}
