//
//  Haptic.swift
//  CineHive
//
//  Created by 이종민 on 4/8/25.
//

import SwiftUI
import UIKit

// MARK: - 햅틱 피드백 유틸리티
enum Haptic {
    // 기본적인 햅틱 피드백 타입
    case light
    case medium
    case heavy
    case soft
    case rigid
    
    // 성공/오류/경고 타입 햅틱
    case success
    case warning
    case error
    
    // 선택 햅틱 (버튼 선택시 미세한 진동)
    case selection
    
    // 햅틱 피드백 실행 함수
    func trigger() {
        switch self {
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        case .rigid:
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
}

// MARK: - View 확장

extension View {
    /// 버튼 탭 시 햅틱 피드백을 제공하는 버튼 모디파이어
    func hapticFeedback(_ feedback: Haptic) -> some View {
        self.simultaneousGesture(TapGesture().onEnded { _ in
            feedback.trigger()
        })
    }
    
    /// 버튼 스타일에 햅틱 피드백을 통합한 모디파이어
    func hapticButtonStyle(haptic: Haptic = .light) -> some View {
        self.buttonStyle(HapticButtonStyle(haptic: haptic))
    }
}

// MARK: - 햅틱 버튼 스타일

struct HapticButtonStyle: ButtonStyle {
    let haptic: Haptic
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                if newValue && !oldValue {
                    haptic.trigger()
                }
            }
    }
}
