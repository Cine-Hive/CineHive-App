//
//  SectionHeader.swift
//  CineHive
//
//  Created by 이종민 on 3/18/25.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    let actionTitle: String
    var action: (() -> Void)? = nil
    var icon: String? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(CHColors.textColor)
            
            Spacer()
            
            if let action = action {
                Button {
                    action()
                } label: {
                    HStack(spacing: 4) {
                        Text(actionTitle)
                            .font(.subheadline)
                            .foregroundColor(CHColors.secondaryColor)
                        
                        if let icon = icon {
                            Image(systemName: icon)
                                .font(.caption)
                                .foregroundColor(CHColors.secondaryColor)
                        }
                    }
                }
                .hapticFeedback(.light)
            }
        }
    }
}

struct SectionWrapper<Content: View>: View {
    let title: String
    let actionTitle: String
    var action: (() -> Void)? = nil
    var icon: String? = "chevron.right"
    let spacing: CGFloat
    let content: () -> Content
    
    init(
        title: String,
        actionTitle: String = "더보기",
        action: (() -> Void)? = nil,
        icon: String? = "chevron.right",
        spacing: CGFloat = 12,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.action = action
        self.icon = icon
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            SectionHeader(
                title: title,
                actionTitle: actionTitle,
                action: action,
                icon: icon
            )
            .padding(.horizontal, 15)
            
            content()
        }
        .padding(.top, 30)
    }
}

#Preview("기본 헤더") {
    VStack(spacing: 20) {
        SectionHeader(title: "인기 영화", actionTitle: "더보기")
        
        SectionHeader(
            title: "최신 영화",
            actionTitle: "전체보기",
            action: { print("더보기 클릭") }
        )
        
        SectionHeader(
            title: "추천 영화",
            actionTitle: "더보기",
            action: { print("더보기 클릭") },
            icon: "chevron.right"
        )
    }
    .padding()
    .background(CHColors.backgroundColor)
}

#Preview("섹션 래퍼") {
    SectionWrapper(
        title: "인기 영화",
        action: { print("더보기 클릭") }
    ) {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 180)
                }
            }
            .padding(.horizontal, 15)
        }
    }
    .background(CHColors.backgroundColor)
}
