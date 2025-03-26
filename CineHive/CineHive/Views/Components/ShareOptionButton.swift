//
//  ShareOptionCard.swift
//  CineHive
//
//  Created by 이종민 on 3/8/25.
//

import SwiftUI

struct ShareOptionButton: View {
    let share: ShareOption
    
    var action: (() -> Void)? = nil
    @State private var isPressed = false
    
    var body: some View {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = true
                }
                
                // 햅틱 피드백
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    action?()
                    withAnimation {
                        isPressed = false
                    }
                }
            }) {
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(isPressed ? share.color.opacity(0.3) : share.color.opacity(0.2))
                            .frame(width: 52, height: 52)
                        
                        Image(systemName: share.icon)
                            .font(.system(size: 20))
                            .foregroundColor(isPressed ? share.highlightColor : share.color)
                    }
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    
                    Text(share.title)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .frame(width: 70)
            }
            .buttonStyle(PlainButtonStyle())
        }
}
