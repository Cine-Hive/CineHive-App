//
//  CustomRefreshView.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct CustomRefreshView: View {
    let isRefreshing: Bool
    
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            if isRefreshing {
                ZStack {
                    Circle()
                        .stroke(CHColors.primaryColor.opacity(0.3), lineWidth: 4)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(CHColors.primaryColor, lineWidth: 4)
                        .frame(width: 40, height: 40)
                        .rotationEffect(Angle(degrees: rotation))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                rotation = 360
                            }
                        }
                }
                
                Text("새로운 콘텐츠를 불러오는 중...")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .frame(height: isRefreshing ? 100 : 0)
        .opacity(isRefreshing ? 1 : 0)
        .animation(.easeInOut(duration: 0.3), value: isRefreshing)
    }
}
