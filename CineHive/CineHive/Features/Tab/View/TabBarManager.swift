//
//  TabBarManager.swift
//  CineHive
//
//  Created by 이종민 on 3/21/25.
//

import SwiftUI

@Observable
class TabBarManager {
    static let shared = TabBarManager()
    var isVisible: Bool = true
    private init() {}
    
    func hide() {
        withAnimation(.easeOut(duration: 0.3)) {
            isVisible = false
        }
    }
    
    func show() {
        withAnimation(.easeIn(duration: 0.3)) {
            isVisible = true
        }
    }
}

struct TabBarVisibilityModifier: ViewModifier {
    @State private var tabBarManager = TabBarManager.shared
    let hidden: Bool
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if hidden {
                    tabBarManager.hide()
                }
            }
            .onDisappear {
                if hidden {
                    tabBarManager.show()
                }
            }
    }
}

extension View {
    func hideTabBar(_ hidden: Bool = true) -> some View {
        modifier(TabBarVisibilityModifier(hidden: hidden))
    }
}
