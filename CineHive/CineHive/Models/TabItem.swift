//
//  TabItem.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

// 탭 아이템 데이터 모델
struct TabItem: Identifiable {
    let id = UUID()
    let icon: String
    let selectedIcon: String
    let title: String
    
    static let home = TabItem(icon: "house", selectedIcon: "house.fill", title: "홈")
    static let search = TabItem(icon: "magnifyingglass", selectedIcon: "magnifyingglass", title: "탐색")
    static let community = TabItem(icon: "quote.bubble", selectedIcon: "quote.bubble.fill", title: "게시판")
    static let profile = TabItem(icon: "person", selectedIcon: "person.fill", title: "프로필")
    
    static let items = [home, search, community, profile]
}
