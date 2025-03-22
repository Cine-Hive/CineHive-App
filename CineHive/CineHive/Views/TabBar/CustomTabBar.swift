//
//  CustomTabBar.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let items: [TabItem]
    
    @Namespace private var tabAnimation
    
    private let backgroundColor = CHColors.backgroundColor
    private let selectedColor = CHColors.primaryColor
    private let unselectedColor = CHColors.gray
    private let textColor = CHColors.textColor
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.gray.opacity(0.4))
            
            HStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    tabButton(for: item, at: index)
                }
            }
            .padding(.vertical, 8)
            .background(backgroundColor)
        }
    }
    
    @ViewBuilder
    private func tabButton(for item: TabItem, at index: Int) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = index
            }
            // 탭 선택 시 햅틱 피드백
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            VStack(spacing: 4) {
                // 아이콘
                Image(systemName: isSelected(index) ? item.selectedIcon : item.icon)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected(index) ? selectedColor : unselectedColor)
                
                // 텍스트
                Text(item.title)
                    .font(.system(size: 10))
                    .fontWeight(isSelected(index) ? .semibold : .regular)
                    .foregroundColor(isSelected(index) ? textColor : unselectedColor)
                
                // 선택 인디케이터
                if isSelected(index) {
                    Circle()
                        .fill(selectedColor)
                        .frame(width: 5, height: 5)
                        .matchedGeometryEffect(id: "tab_indicator", in: tabAnimation)
                        .padding(.top, 2)
                } else {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 5, height: 5)
                        .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(TabButtonStyle())
    }
    
    private func isSelected(_ index: Int) -> Bool {
        selectedTab == index
    }
}

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Preview
#Preview {
    CustomTabBar(selectedTab: .constant(0), items: TabItem.items)
        .background(CHColors.textColor)
}
