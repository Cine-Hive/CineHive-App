//
//  CHColors.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct CHColors {
    // 메인 색상
    static let primaryColor = Color("PrimaryColor")
    static let backgroundColor = Color("BackgroundColor")
    static let textColor = Color("TextColor")
    static let secondaryColor = Color.gray
    static let font = Color("FontColor")
    
    // 기본 UI 요소 색상
    static let inputBackground = Color(white: 0.15)
    static let cardBackground = Color(white: 0.15)
    static let starColor = Color.yellow
    static let divider = Color.gray.opacity(0.3)
    
    // 그레이 스케일
    static let gray = Color.gray
    static let darkGray = Color(white: 0.3)
    static let mediumGray = Color(white: 0.5)
    static let lightGray = Color(white: 0.7)
    static let extraLightGray = Color(white: 0.9)
    
    // 투명도가 있는 색상
    static let overlay = Color.black.opacity(0.5)
    static let shadowColor = Color.black.opacity(0.2)
    static let highlightOverlay = Color.white.opacity(0.1)
    
    // 피드백 색상
    struct Feedback {
        static let success = Color.green
        static let warning = Color.orange
        static let error = Color.red
        static let info = Color.blue
    }
    
    // 버튼 색상
    struct Button {
        static let primary = Color("LoginBtnColor")
        static let kakao = Color("KakaoColor")
        static let naver = Color("NaverColor")
        static let google = Color("GoogleColor")
        static let disabled = Color.gray
        
        // 버튼 상태별 색상
        static let pressed = primaryColor.opacity(0.8)
        static let hover = primaryColor.opacity(0.9)
        
        // 보조 버튼 색상
        static let secondary = Color(white: 0.25)
        static let tertiary = Color.clear
    }
    
    // OTT 서비스 색상
    struct OTT {
        static let netflix = Color.red
        static let netflixDark = Color(hex: "#B81D24")
        static let netflixLight = Color(hex: "#E50914")
        
        static let disney = Color.blue
        static let disneyDark = Color(hex: "#0E1954")
        static let disneyLight = Color(hex: "#1F3DBC")
        
        static let apple = Color.gray
        static let appleDark = Color(hex: "#1D1D1F")
        
        static let wavve = Color.cyan
        static let wavveDark = Color(hex: "#1E88E5")
        
        static let tving = Color.red.opacity(0.8)
        static let tvingDark = Color(hex: "#C4151C")
    }
    
    // 콘텐츠 유형별 색상
    struct ContentType {
        static let movie = Color(hex: "#FF4081")
        static let tv = Color(hex: "#7C4DFF")
        static let documentary = Color(hex: "#009688")
        static let animation = Color(hex: "#FFC107")
        static let community = Color(hex: "#00BCD4")
    }
    
    // 장르별 색상
    struct Genre {
        static let action = Color(hex: "#F44336")
        static let comedy = Color(hex: "#FFEB3B")
        static let drama = Color(hex: "#9C27B0")
        static let horror = Color(hex: "#263238")
        static let sciFi = Color(hex: "#3F51B5")
        static let romance = Color(hex: "#E91E63")
        static let thriller = Color(hex: "#795548")
        static let fantasy = Color(hex: "#673AB7")
    }
    
    // 그라데이션
    struct Gradient {
        static let primary = LinearGradient(
            gradient: SwiftUI.Gradient(colors: [primaryColor, primaryColor.opacity(0.7)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let dark = LinearGradient(
            gradient: SwiftUI.Gradient(colors: [Color.black, Color(white: 0.1)]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let overlay = LinearGradient(
            gradient: SwiftUI.Gradient(colors: [Color.clear, Color.black.opacity(0.7), Color.black]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
