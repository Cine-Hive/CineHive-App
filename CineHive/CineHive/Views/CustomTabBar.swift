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
    
    // 애니메이션 속성
    @Namespace private var tabAnimation
    
    // 색상
    private let backgroundColor = CHColors.backgroundColor
    private let selectedColor = CHColors.primaryColor
    private let unselectedColor = CHColors.secondaryColor
    private let textColor = CHColors.textColor
    
    var body: some View {
        VStack(spacing: 0) {
            // 구분선
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 0.5)
            
            HStack(spacing: 0) {
                ForEach(0..<items.count, id: \.self) { index in
                    tabButton(item: items[index], index: index)
                }
            }
            .padding(.top, 8)
            .padding(.bottom, getSafeAreaBottom())
            .background(backgroundColor)
        }
    }
    
    private func getSafeAreaBottom() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first?.safeAreaInsets.bottom ?? 10
    }
    
    // 각 탭 버튼
    @ViewBuilder
    private func tabButton(item: TabItem, index: Int) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = index
            }
            
            // 탭 선택 시 햅틱 피드백
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        } label: {
            VStack(spacing: 4) {
                // 아이콘
                Image(systemName: selectedTab == index ? item.selectedIcon : item.icon)
                    .font(.system(size: 22))
                    .foregroundColor(selectedTab == index ? selectedColor : unselectedColor)
                
                // 텍스트
                Text(item.title)
                    .font(.system(size: 10))
                    .fontWeight(selectedTab == index ? .semibold : .regular)
                    .foregroundColor(selectedTab == index ? textColor : unselectedColor)
                
                // 선택 인디케이터
                if selectedTab == index {
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
}

// 탭 버튼 스타일
struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// 커스텀 탭바를 사용하는 메인 뷰
struct CustomTabView<Content: View>: View {
    @Binding var selectedTab: Int
    let content: Content
    
    init(selectedTab: Binding<Int>, @ViewBuilder content: () -> Content) {
        self._selectedTab = selectedTab
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 메인 컨텐츠
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all, edges: .bottom)
            
            // 커스텀 탭바
            CustomTabBar(selectedTab: $selectedTab, items: TabItem.items)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0), items: TabItem.items)
        .preferredColorScheme(.dark)
}
