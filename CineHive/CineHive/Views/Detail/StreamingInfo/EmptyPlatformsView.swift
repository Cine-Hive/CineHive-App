//
//  EmptyPlatformsView.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

import SwiftUI

//임시 테마사용
struct PlatformInfoSheetTheme {
    static let background = Color.black
    static let text = Color.white
    static let secondaryText = Color.gray
    static let cardBackground = Color(white: 0.15)
    static let accent = Color.red
    static let divider = Color.gray.opacity(0.3)
    static let priceBackground = Color.black.opacity(0.3)
    static let priceColor = Color.green
}

struct EmptyPlatformsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tv.slash")
                .font(.system(size: 40))
                .foregroundColor(PlatformInfoSheetTheme.accent)
            
            Text("현재 스트리밍 서비스에서 제공되지 않습니다")
                .font(.headline)
                .foregroundColor(PlatformInfoSheetTheme.text)
                .multilineTextAlignment(.center)
            
            Text("영화관에서 상영 중이거나 다른 플랫폼에서 출시 예정일 수 있습니다")
                .font(.caption)
                .foregroundColor(PlatformInfoSheetTheme.secondaryText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(PlatformInfoSheetTheme.background)
        .cornerRadius(12)
    }
}

#Preview {
    EmptyPlatformsView()
}
