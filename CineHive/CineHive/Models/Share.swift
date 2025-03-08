//
//  Share.swift
//  CineHive
//
//  Created by 이종민 on 3/8/25.
//

import SwiftUI

struct Share: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let shareOption: ShareOption
    let color: Color
    let highlightColor: Color
}

enum ShareOption: CaseIterable {
    case message
    case kakaotalk
    case instagram
    case copyURL
    case twitter
    case systemShare
}

extension ShareOption {
    var title: String {
        switch self {
        case .message: return "메시지"
        case .kakaotalk: return "카카오톡"
        case .instagram: return "인스타그램"
        case .copyURL: return "URL 복사"
        case .twitter: return "트위터"
        case .systemShare: return "더보기"
        }
    }
    
    var icon: String {
        switch self {
        case .message: return "message.fill"
        case .kakaotalk: return "bubble.left.fill"
        case .instagram: return "camera.fill"
        case .copyURL: return "doc.on.doc"
        case .twitter: return "bird"
        case .systemShare: return "ellipsis"
        }
    }
    
    var color: Color {
        switch self {
        case .message: return .green
        case .kakaotalk: return .yellow
        case .instagram: return .purple
        case .copyURL: return .red
        case .twitter: return .blue
        case .systemShare: return .gray
        }
    }
    
    var highlightColor: Color {
        return self.color
    }
}
