//
//  OTTService.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

// OTT 서비스 타입 정의
enum OTT: String, CaseIterable {
    case netflix = "넷플릭스"
    case disney = "디즈니+"
    case apple = "애플TV+"
    case wavve = "웨이브"
    case tving = "티빙"
    
    var name: String {
        return self.rawValue
    }
    
    var iconName: String {
        switch self {
        case .netflix: return "n.square.fill"
        case .disney: return "d.square.fill"
        case .apple: return "apple.logo"
        case .wavve: return "w.square.fill"
        case .tving: return "t.square.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .netflix: return CHColors.OTT.netflix
        case .disney: return CHColors.OTT.disney
        case .apple: return CHColors.OTT.apple
        case .wavve: return CHColors.OTT.wavve
        case .tving: return CHColors.OTT.tving
        }
    }
}
