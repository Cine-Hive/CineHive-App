//
//  CHColors.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct CHColors {
    // 에셋에 정의된 색상들
    static let primaryColor = Color("PrimaryColor")
    static let backgroundColor = Color("BackgroundColor")
    static let textColor = Color("TextColor")
    static let secondaryColor = Color("SecondaryColor")
    static let font = Color("FontColor")
    
    static let inputBackground = Color(white: 0.15)
    static let cardBackground = Color(white: 0.15)
    static let starColor = Color.yellow
    static let divider = Color.gray.opacity(0.3)
    
    struct Button {
        static let primary = Color("LoginBtnColor") // 또는 Color(hex: "#FF2F6E")
        static let kakao = Color("KakaoColor")
        static let naver = Color("NaverColor")
        static let google = Color("GoogleColor")
        static let disabled = Color.gray
    }
    
    struct OTT {
        static let netflix = Color.red
        static let disney = Color.blue
        static let apple = Color.gray
        static let wavve = Color.cyan
        static let tving = Color.red.opacity(0.8)
    }
}

// 다크/라이트 모드에 따른 색상 변경을 위한 Color 익스텐션
extension Color {
    static func dynamicColor(light: Color, dark: Color) -> Color {
        return Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}
