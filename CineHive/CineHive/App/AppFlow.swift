//
//  AppFlow.swift
//  CineHive
//
//  Created by 이종민 on 3/31/25.
//

import Foundation

enum AppFlow: Equatable {
    // 인증
    case auth
    case login
    case signUp
    case onboarding
    
    // 메인
    case main
    
    // 상세 화면 흐름
//    case contentDetail(contentId: String)
//    case profile
//    case settings
    
    
//    case splash
//    case error(message: String)
    
}
